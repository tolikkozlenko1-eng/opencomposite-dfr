# OpenComposite DFR

Gaze-tracked foveated rendering as an **OpenXR API layer**.

This is **not** OpenComposite. OpenComposite stays the OpenVR-to-OpenXR bridge under the game. This repo is the extra layer you drop in the same way people drop **Primashock**: one DLL in the OpenXR Toolkit slot.

You cannot run this DLL and stock Primashock / stock OpenXR Toolkit at the same time. They use the same layer name (`XR_APILAYER_MBUCCHIA_toolkit`).

## What it does

The gaze circle works universally on OpenComposite games.

- One eye-tracked circle. The headset reports one gaze pose through `XR_EXT_eye_gaze_interaction`, and that pose is projected into the picture the game is drawing
- A game that draws each eye as its own picture gets the circle on that picture
- A game that draws both eyes into one wide side-by-side picture gets a circle in each half, when each half matches the per-eye aspect. Same rule, no separate game
- NVIDIA D3D11 variable rate shading: inner disk full rate, outside 1/16
- Needs an NVIDIA GPU and a headset whose OpenXR runtime reports eye gaze (Pimax Dream Air, Crystal, Varjo, Quest Pro, and others)

## What this is not

- Not a second copy of OpenComposite
- Not OpenComposite Unleashed
- Not a DLSS / temporal-AA plugin
- Not your personal resolution, sharpen, or turbo numbers. Those stay in the OpenXR Toolkit overlay per game

## Install (like Primashock)

1. Close the game. The layer DLL is locked while a game is running
2. Back up `C:\Program Files\OpenXR-Toolkit\XR_APILAYER_MBUCCHIA_toolkit.dll`
3. Copy the built `XR_APILAYER_MBUCCHIA_toolkit.dll` over that file
4. Copy `VRS.hlsl` into `C:\Program Files\OpenXR-Toolkit\shaders\` only if you changed the shader
5. Do not copy a `.json` unless you are installing the layer from scratch
6. Do not write someone else's registry. The overlay already stores per-app keys under `HKCU\SOFTWARE\OpenXR_Toolkit`

Open the Toolkit overlay in-game (Ctrl+F2). Turn on variable rate shading, custom inner/outer rates, and eye tracking.

## Source

This project is a fork of [mbucchia/OpenXR-Toolkit](https://github.com/mbucchia/OpenXR-Toolkit) (MIT). Matthieu Bucchianeri's Toolkit is the layer host. Our change is the OpenComposite gaze circle: one circle on a per-eye picture, and a circle in each half of a side-by-side picture.

The full Toolkit tree (so you can build) lives in the fork: [tolikkozlenko1-eng/OpenXR-Toolkit](https://github.com/tolikkozlenko1-eng/OpenXR-Toolkit). Gaze DFR lives on the `gaze-dfr` branch.

Build: Visual Studio 2022 (`v143`), `OpenXR-Toolkit.sln`, target `XR_APILAYER_MBUCCHIA_toolkit`, Release x64. The post-build copy/sign step can fail on paths with spaces. The DLL is still written to `bin\x64\Release`. Do not commit `nuget.exe`.

## License

MIT. See `LICENSE`. Keep the original Toolkit copyright notices.
