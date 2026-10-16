# OpenComposite DFR

Gaze-tracked foveated rendering as an **OpenXR API layer**.

This is **not** OpenComposite. OpenComposite stays the OpenVR-to-OpenXR bridge under the game. This repo is the extra layer you drop in the same way people drop **Primashock**: one DLL in the OpenXR Toolkit slot.

You cannot run this DLL and stock Primashock / stock OpenXR Toolkit at the same time. They use the same layer name (`XR_APILAYER_MBUCCHIA_toolkit`).

## What it does

- One eye-tracked circle (both eyes share one gaze pose from `XR_EXT_eye_gaze_interaction`)
- NVIDIA D3D11 variable rate shading: inner disk full rate, outside 1/16
- Built for OpenComposite games that draw **each eye as its own picture**. That path is meant to work universally on those titles
- Tested in Elite Dangerous (with EDVR) and Skyrim VR
- Needs an NVIDIA GPU and a headset whose OpenXR runtime reports eye gaze (Pimax Dream Air, Crystal, Varjo, Quest Pro, and others)
- Fallout 4 VR draws one wide side-by-side picture. Leave foveation **off** for that game
- Elite station names, menus, and target marks can stay sharp without sharpening the world outside the circle. That match is Elite-only (`OpenComposite_EliteDangerous64` / any application name that contains `EliteDangerous`). Other games keep the gaze circle

## What this is not

- Not a second copy of OpenComposite
- Not OpenComposite Unleashed
- Not a DLSS / temporal-AA plugin
- Not your personal resolution, sharpen, or turbo numbers. Those stay in the OpenXR Toolkit overlay per game

## Install (like Primashock)

1. Close the game (`EliteDangerous64`, `SkyrimVR`, and `Fallout4VR` must not be running)
2. Back up `C:\Program Files\OpenXR-Toolkit\XR_APILAYER_MBUCCHIA_toolkit.dll`
3. Copy the built `XR_APILAYER_MBUCCHIA_toolkit.dll` over that file
4. Copy `VRS.hlsl` into `C:\Program Files\OpenXR-Toolkit\shaders\` only if you changed the shader
5. Do not copy a `.json` unless you are installing the layer from scratch
6. Do not write someone else's registry. The overlay already stores per-app keys under `HKCU\SOFTWARE\OpenXR_Toolkit`

Open the Toolkit overlay in-game (Ctrl+F2). Turn on variable rate shading, custom inner/outer rates, and eye tracking.

## Source

This project is a fork of [mbucchia/OpenXR-Toolkit](https://github.com/mbucchia/OpenXR-Toolkit) (MIT). Matthieu Bucchianeri's Toolkit is the layer host. Our changes are the OpenComposite gaze circle, the one-mask-per-eye-picture path, and the Elite overlay full-rate gate.

The full Toolkit tree (so you can build) lives in the fork: [tolikkozlenko1-eng/OpenXR-Toolkit](https://github.com/tolikkozlenko1-eng/OpenXR-Toolkit). Gaze DFR lives on the `gaze-dfr` branch.

Build: Visual Studio 2022 (`v143`), `OpenXR-Toolkit.sln`, target `XR_APILAYER_MBUCCHIA_toolkit`, Release x64. The post-build copy/sign step can fail on paths with spaces. The DLL is still written to `bin\x64\Release`. Do not commit `nuget.exe`.

## License

MIT. See `LICENSE`. Keep the original Toolkit copyright notices.
