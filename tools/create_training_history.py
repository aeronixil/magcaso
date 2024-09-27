#!/usr/bin/env python3
"""Create a labeled classroom simulation, preserving the existing Git history."""
from __future__ import annotations

import argparse
from datetime import datetime, timedelta, timezone
import os
import random
from pathlib import Path
import subprocess

from build_curriculum import lessons, write_curriculum

ROOT = Path(__file__).resolve().parents[1]
ZONE = timezone(timedelta(hours=5, minutes=30))
START = datetime(2024, 9, 28, 0, 0, tzinfo=ZONE)
END = datetime(2026, 9, 28, 0, 0, tzinfo=ZONE)
PREFIX = "[classroom simulation]"


def git(*args: str, env=None) -> str:
    return subprocess.check_output(
        ["git", *args], cwd=ROOT, env=env, text=True, encoding="utf-8"
    ).strip()


def simulation_dates(count):
    """Reproducible quiet stretches and busy days, keeping commit order intact."""
    if count < 3:
        raise ValueError("The classroom timeline needs at least three commits")
    rng = random.Random(20260928)
    active_days = rng.sample(range(1, (END - START).days), min(145, count - 2))
    days = active_days + rng.choices(active_days, k=count - 2 - len(active_days))
    dates = {START, END}
    for day in days:
        stamp = START + timedelta(days=day, seconds=rng.randrange(8 * 3600, 20 * 3600))
        while stamp in dates:
            stamp += timedelta(seconds=1)
        dates.add(stamp)
    return sorted(dates)


def schedule():
    cards = lessons()
    messages = [f"{PREFIX} modernize Flutter and add the learning app"]
    messages += [f"{PREFIX} add lesson {card['id']}" for card in cards]
    return list(zip(simulation_dates(len(messages)), messages))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base", required=True, help="Original HEAD; never rewritten")
    parser.add_argument("--execute", action="store_true", help="Create local commits")
    parser.add_argument("--email", help="Optional author/committer email for these new commits only")
    args = parser.parse_args()
    base = git("rev-parse", "--verify", args.base + "^{commit}")
    plan = schedule()
    print(f"{len(plan)} non-empty commits, {START.isoformat()} through {END.isoformat()}")
    if not args.execute:
        for stamp, message in plan:
            print(stamp.isoformat(), message)
        return
    if git("branch", "--show-current") != "codex/classroom-modernization":
        raise SystemExit("Run only on the codex/classroom-modernization branch.")
    git("merge-base", "--is-ancestor", base, "HEAD")
    completed = git("log", "--reverse", "--format=%s", f"{base}..HEAD").splitlines()
    if completed != [message for _, message in plan[:len(completed)]]:
        raise SystemExit("Existing commits differ from the plan; refusing to rewrite history.")
    # Any retry resumes the matching prefix; no reset, rebase, amend or force push.
    for index, (stamp, message) in enumerate(plan):
        if index < len(completed):
            continue
        write_curriculum(index)
        if index == 0:
            # Markdown lessons may already exist from pre-commit validation.
            git("add", "--all", "--", ".", ":!docs/lessons", ":!docs/activity.html")
        else:
            card_path = f"docs/lessons/{lessons()[index - 1]['id']}.md"
            git("add", "--", "assets/lessons/index.json", card_path)
        if not git("diff", "--cached", "--name-only"):
            raise SystemExit(f"Commit {index} has no change; empty commits are not allowed.")
        env = dict(os.environ)
        if args.email:
            env["GIT_AUTHOR_EMAIL"] = args.email
            env["GIT_COMMITTER_EMAIL"] = args.email
        env["GIT_AUTHOR_DATE"] = stamp.isoformat(timespec="seconds")
        env["GIT_COMMITTER_DATE"] = env["GIT_AUTHOR_DATE"]
        git("commit", "-m", message,
            "-m", "Synthetic classroom timeline. Dates are teaching data, not actual work dates.",
            env=env)
        print(f"{index + 1}/{len(plan)} {stamp.date()} {message}", flush=True)
    assert int(git("rev-list", "--count", f"{base}..HEAD")) == len(plan)
    print("Complete. Original history preserved. Nothing pushed.")


if __name__ == "__main__":
    main()
