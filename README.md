# OpenComposite DFR

Gaze-tracked foveated rendering as an **OpenXR API layer**.

## Download

[Download opencomposite-dfr.zip](https://github.com/tolikkozlenko1-eng/opencomposite-dfr/releases/latest/download/opencomposite-dfr.zip)

Close the game. Unzip the file. Right-click `Install.bat` and choose Run as administrator.

Start the game. Press Ctrl+F2. Turn on variable rate shading and eye tracking.

The package replaces `C:/Program Files/OpenXR-Toolkit/XR_APILAYER_MBUCCHIA_toolkit.dll` and registers the layer. Stock OpenXR Toolkit and Primashock use that same slot, so they cannot run at the same time. Per-game overlay settings stay in the registry. This package does not change them.

Needs an NVIDIA GPU, OpenComposite, and a headset whose OpenXR runtime reports eye gaze (Pimax Dream Air, Crystal, Varjo, Quest Pro, and others).

This is **not** OpenComposite. OpenComposite stays the OpenVR-to-OpenXR bridge under the game. This repo is the extra layer you drop in the same way people drop **Primashock**: one DLL in the OpenXR Toolkit slot.

## What it does

The gaze circle works universally on OpenComposite games.

- One eye-tracked circle. The headset reports one gaze pose through `XR_EXT_eye_gaze_interaction`, and that pose is projected into the picture the game is drawing
- A game that draws each eye as its own picture gets the circle on that picture
- A game that draws both eyes into one wide side-by-side picture gets a circle in each half, when each half matches the per-eye aspect. Same rule, no separate game
- NVIDIA D3D11 variable rate shading: inner disk full rate, outside 1/16

## What this is not

- Not a second copy of OpenComposite
- Not OpenComposite Unleashed
- Not a DLSS / temporal-AA plugin
- Not your personal resolution, sharpen, or turbo numbers. Those stay in the OpenXR Toolkit overlay per game

## Source

This project is a fork of [mbucchia/OpenXR-Toolkit](https://github.com/mbucchia/OpenXR-Toolkit) (MIT). Matthieu Bucchianeri's Toolkit is the layer host. Our change is the OpenComposite gaze circle: one circle on a per-eye picture, and a circle in each half of a side-by-side picture.

The full Toolkit tree (so you can build) lives in the fork: [tolikkozlenko1-eng/OpenXR-Toolkit](https://github.com/tolikkozlenko1-eng/OpenXR-Toolkit). Gaze DFR lives on the `gaze-dfr` branch.

Build: Visual Studio 2022 (`v143`), `OpenXR-Toolkit.sln`, target `XR_APILAYER_MBUCCHIA_toolkit`, Release x64. The post-build copy/sign step can fail on paths with spaces. The DLL is still written to `bin/x64/Release`. Do not commit `nuget.exe`.

## License

MIT. See `LICENSE`. Keep the original Toolkit copyright notices.
