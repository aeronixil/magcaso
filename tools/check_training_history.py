#!/usr/bin/env python3
"""Check the classroom history and curriculum without changing the repository."""
import json
from pathlib import Path
import subprocess

from create_training_history import schedule

ROOT = Path(__file__).resolve().parents[1]
BASE = "5ea759ec65c0b6a9811e64f8b9df03f9e04f1051"


def git(*args):
    return subprocess.check_output(["git", *args], cwd=ROOT, text=True, encoding="utf-8").strip()


def main():
    git("merge-base", "--is-ancestor", BASE, "HEAD")
    commits = git("log", "--reverse", "--format=%H|%aI|%cI|%s", f"{BASE}..HEAD").splitlines()
    plan = schedule()
    assert len(commits) == len(plan) == 251, "Expected 251 added commits"
    for index, (row, (stamp, message)) in enumerate(zip(commits, plan)):
        sha, author, committer, subject = row.split("|", 3)
        expected = stamp.isoformat(timespec="seconds")
        assert author == committer == expected, f"Date mismatch at {sha}"
        assert subject == message, f"Subject mismatch at {sha}"
        paths = git("diff-tree", "--no-commit-id", "--name-only", "-r", sha).splitlines()
        assert paths, f"Empty commit: {sha}"
        if index:
            assert len(paths) == 2, f"Expected lesson and index changes at {sha}"
            assert "assets/lessons/index.json" in paths
            assert any(path.startswith("docs/lessons/") for path in paths)
    cards = json.loads((ROOT / "assets/lessons/index.json").read_text(encoding="utf-8"))
    assert len(cards) == len({card["id"] for card in cards}) == 250
    assert all(
        all(isinstance(card[key], str) and card[key].strip()
            for key in ("id", "title", "topic", "summary", "body", "exercise"))
        for card in cards
    )
    assert len(list((ROOT / "docs/lessons").glob("*.md"))) == 250
    assert not git("status", "--porcelain"), "Working tree has pending changes"
    print("PASS: 251 non-empty commits; matching author/committer dates; original ancestor retained.")
    print("PASS: 250 unique lessons; every lesson commit changes its note and the app index.")
    print(f"PASS: timeline {plan[0][0].date()} through {plan[-1][0].date()}; clean working tree.")


if __name__ == "__main__":
    main()
