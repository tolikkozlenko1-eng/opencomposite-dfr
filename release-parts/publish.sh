#!/bin/bash
set -euo pipefail
cat release-parts/part-* | base64 -d > opencomposite-dfr.zip
unzip -t opencomposite-dfr.zip
cat > /tmp/notes.txt <<'EOF'
Gaze-tracked foveated rendering for OpenComposite games.

Download opencomposite-dfr.zip. Close the game. Unzip, then right-click Install.bat and choose Run as administrator.
In the game press Ctrl+F2 and turn on variable rate shading and eye tracking.

NVIDIA GPU. The headset OpenXR runtime must report eye gaze.
This replaces the OpenXR Toolkit DLL. Stock Toolkit and Primashock use the same slot.

DLL SHA256: 03615238DC8552266821AC41A9296E38C161CF24F54B1C38CCB79AA2A629D4E9
EOF
gh release create v1.0.0 opencomposite-dfr.zip --repo "$GITHUB_REPOSITORY" --title "OpenComposite DFR" --notes-file /tmp/notes.txt
