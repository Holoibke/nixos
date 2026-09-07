import gzip
import json
import os
import re
import subprocess
import sys

(WAL_FILE, SKELETON, OUT_DIR,
 BROTLI, SYSTEMCTL, CONTAINER_UNIT) = sys.argv[1:7]

OUT_CSS = os.path.join(OUT_DIR, "sxng-ltr.min.css")

FALLBACK = {
    "background": "#232136",
    "foreground": "#e0def4",
    "color0": "#232136", "color1": "#eb6f92", "color2": "#3e8fb0",
    "color3": "#f6c177", "color4": "#9ccfd8", "color5": "#c4a7e7",
    "color6": "#ea9a97", "color7": "#e0def4", "color8": "#6e6a86",
    "color9": "#eb6f92", "color10": "#3e8fb0", "color11": "#f6c177",
    "color12": "#9ccfd8", "color13": "#c4a7e7", "color14": "#ea9a97",
    "color15": "#e0def4",
}


def hex_to_rgb_triplet(value):
    value = value.lstrip("#")
    if len(value) == 3:
        value = "".join(c * 2 for c in value)
    try:
        return "{}, {}, {}".format(
            int(value[0:2], 16), int(value[2:4], 16), int(value[4:6], 16)
        )
    except ValueError:
        return None


def load_palette():
    palette = dict(FALLBACK)
    try:
        with open(WAL_FILE, encoding="utf-8") as f:
            data = json.load(f)
        special = data.get("special") or {}
        colors = data.get("colors") or {}
        palette["background"] = (
            special.get("background")
            or colors.get("color0")
            or palette["background"]
        )
        palette["foreground"] = (
            special.get("foreground")
            or colors.get("color7")
            or palette["foreground"]
        )
        for i in range(16):
            key = "color{}".format(i)
            palette[key] = (
                colors.get(key) or data.get(key) or palette[key]
            )
    except (OSError, ValueError) as exc:
        print("searxng-theme: cannot read {} ({})".format(WAL_FILE, exc)
              + ", using fallback palette")
    rgb = hex_to_rgb_triplet(palette["foreground"])
    if rgb is None:
        rgb = "224, 222, 244"
    palette["foreground_rgb"] = rgb
    return palette


def atomic_write(path, data):
    tmp = path + ".tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    os.replace(tmp, path)


def main():
    palette = load_palette()
    with open(SKELETON, encoding="utf-8") as f:
        css = f.read()

    tokens = set(re.findall(r"\{\{([a-z0-9_]+)\}\}", css))
    unknown = tokens - set(palette)
    if unknown:
        raise SystemExit(
            "searxng-theme: unknown placeholders: {}".format(sorted(unknown))
        )
    for key, value in palette.items():
        css = css.replace("{{" + key + "}}", value)

    css_bytes = css.encode("utf-8")

    try:
        with open(OUT_CSS, "rb") as f:
            old = f.read()
    except OSError:
        old = None

    missing_variants = not (
        os.path.exists(OUT_CSS + ".gz") and os.path.exists(OUT_CSS + ".br")
    )

    if old == css_bytes and not missing_variants:
        print("searxng-theme: palette unchanged, nothing to do")
        return

    atomic_write(OUT_CSS, css_bytes)
    atomic_write(OUT_CSS + ".gz",
                 gzip.compress(css_bytes, compresslevel=9, mtime=0))
    brotli = subprocess.run(
        [BROTLI, "-q", "11", "-c"],
        input=css_bytes, stdout=subprocess.PIPE, check=True,
    )
    atomic_write(OUT_CSS + ".br", brotli.stdout)
    subprocess.run(
        [SYSTEMCTL, "try-restart", CONTAINER_UNIT], check=False
    )
    print("searxng-theme: rendered theme from {}".format(WAL_FILE))


if __name__ == "__main__":
    main()
