# Website Showcase

A static gallery of website designs. `index.html` shows every site in `sites/` as a card with a screenshot. It uses plain HTML, CSS and JS, has no build step, and opens directly from disk.

## Layout

```
index.html            Showcase page (Awwwards "Nominees" style). The site list lives in the SITES array in its <script>.
sites/                The websites. Each is one self-contained HTML file with inlined CSS/JS/images.
snapshots/            1440x900 screenshots, one per site, named <id>.png (e.g. v4.png).
scripts/snapshot.ps1  Regenerates the screenshots with headless Chrome (falls back to Edge).
```

## Conventions

- Site files are named `<id>-<slug>.html`, where `<id>` is `v1`, `v2`, … in order of creation (oldest = v1). The snapshot script takes everything before the first `-` as the id.
- The sites in `sites/` are standalone exports. Don't edit them as part of showcase work, and don't add relative asset references to them; they must keep working after being moved.
- `SITES` in `index.html` is ordered newest first. The first entry gets the "Latest" badge and is linked from the dock's "Visit latest" button.

## Adding a site

1. Copy the HTML file to `sites/` as `v<N>-<slug>.html`.
2. Take its screenshot: `powershell -ExecutionPolicy Bypass -File scripts\snapshot.ps1 -Only v<N>` (leave out `-Only` to redo all of them).
3. Add an entry at the top of `SITES` in `index.html`: `id`, `title`, `by`, `date`, `size`, `file`, `shot`.
4. Open `index.html` and check the new card.

## Notes

- Animated heroes are captured after `--virtual-time-budget=5000` (about 5s). If a screenshot catches a mid-animation frame, raise that value in the script.
- The Inter font loads from Google Fonts. When offline, the page falls back to system fonts.
