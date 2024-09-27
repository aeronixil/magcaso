#!/usr/bin/env python3
"""Render an offline heatmap from the actual classroom Git commit timestamps."""
from collections import Counter
from datetime import date, timedelta
from html import escape
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def main():
    raw = subprocess.check_output(
        ["git", "log", "--format=%aI|%s"], cwd=ROOT, text=True, encoding="utf-8"
    )
    counts = Counter(
        date.fromisoformat(row[:10])
        for row in raw.splitlines()
        if "|[classroom simulation]" in row
    )
    if not counts:
        raise SystemExit("Create the training commits before rendering the heatmap.")
    start, end = min(counts), max(counts)
    sunday = start - timedelta(days=(start.weekday() + 1) % 7)
    cells = []
    cursor = sunday
    while cursor <= end:
        week = (cursor - sunday).days // 7
        row = (cursor.weekday() + 1) % 7
        count = counts[cursor]
        palette = ["#212b36", "#0e4429", "#006d32", "#26a641", "#39d353"]
        color = palette[min(count, 4)]
        title = escape(f"{cursor.isoformat()}: {count} simulated commit(s)")
        cells.append(
            f'<rect x="{week * 13}" y="{row * 13}" width="10" height="10" '
            f'rx="2" fill="{color}"><title>{title}</title></rect>'
        )
        cursor += timedelta(days=1)
    width = ((end - sunday).days // 7 + 1) * 13
    html = (
        '<!doctype html><html lang="en"><meta charset="utf-8">'
        '<meta name="viewport" content="width=device-width,initial-scale=1">'
        '<title>Magcaso classroom activity</title>'
        '<style>body{background:#0d1117;color:#e6edf3;font:16px system-ui;'
        'max-width:1450px;margin:60px auto;padding:24px}h1{font-size:32px}'
        '.scroll{overflow-x:auto;padding:24px 0}p{line-height:1.7;color:#aebdca}'
        'strong{color:#39d353}</style><h1>Magcaso classroom activity</h1>'
        f'<p><strong>{sum(counts.values())} commits</strong> on {len(counts)} days'
        f' &middot; {start} &ndash; {end}</p>'
        '<p>Simulated dates for teaching. This chart reads the local Git history; '
        'it is not a GitHub profile screenshot or evidence of historical work.</p>'
        f'<div class="scroll"><svg role="img" aria-label="Simulated contribution heatmap" '
        f'width="{width}" height="95">{"".join(cells)}</svg></div>'
        '<p>Darker green means fewer commits; brighter green means a busier day. '
        'Hover over a square for its date and commit count. Each new lesson '
        'commit adds a Markdown exercise and updates the app’s lesson index.</p>'
        '<p>The app upgrade is one commit; the remaining 250 commits add lessons.'
        ' GitHub profile contributions also depend on the branch, verified email, '
        'repository eligibility, and GitHub processing.</p></html>'
    )
    target = ROOT / "docs" / "activity.html"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(html, encoding="utf-8")
    print(target)


if __name__ == "__main__":
    main()
