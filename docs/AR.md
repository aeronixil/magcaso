# 3D and AR studio

Open the cube/AR button in the lesson browser's top bar. Choose Astronaut or
Expressive robot, drag to rotate, pinch/scroll to zoom, or toggle automatic rotation.
Use **Reload model** to retry a network failure or reset the camera.

On a compatible phone, the viewer's AR button launches placement in your space.
Allow camera access and scan a well-lit floor or table. Unsupported devices still
offer interactive 3D. Models are streamed from modelviewer.dev and require internet.

## Supported paths and limits

- Android: Scene Viewer via the Google app, with Google Play Services for AR
  installed on an ARCore-compatible device. A 3D fallback is possible.
- Web: current browsers for 3D. WebXR AR needs a compatible mobile browser,
  camera permission, and HTTPS (localhost is only useful on the same device).
- iOS: Quick Look; Astronaut has an explicit USDZ source. Embedded-browser AR
  availability varies, including known limitations on iOS 16 and later in the
  model_viewer_plus package. Use a supported Safari/Quick Look path when available.
- Windows, Linux and macOS native apps show a browser/mobile guidance message.

The model_viewer_plus widget uses its bundled model-viewer JavaScript. Android
permits cleartext only for the widget's loopback server; remote assets use HTTPS.
The app does not upload camera images or store models. Camera permission and
tracking are handled by the browser or native AR viewer.

Automated tests cover model selection, rotation, reload and narrow layouts.
Actual camera tracking and surface placement require an AR-capable physical
device; they have not been tested on this Windows preparation machine.

## Sample model attribution

Assets are referenced remotely and not redistributed in this repository.

- **Astronaut** by **Poly**, [CC BY 2.0](https://creativecommons.org/licenses/by/2.0/).
  [Original source](https://poly.google.com/view/dLHpzNdygsg) (legacy Poly link).
  No modifications to the model.
- **RobotExpressive** by **Tomás Laulhé**,
  [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
  [Source](https://github.com/mrdoob/three.js/tree/dev/examples/models/gltf/RobotExpressive).

Credits follow the upstream
[asset attribution file](https://github.com/google/model-viewer/blob/master/packages/shared-assets/ATTRIBUTIONS.md).
Implementation references:
[model_viewer_plus](https://pub.dev/packages/model_viewer_plus) and
[model-viewer AR modes](https://modelviewer.dev/examples/augmentedreality/).

## Classroom timeline

This feature uses the simulated author and committer date **2025-09-28**.
It was implemented for the classroom demonstration, not actually developed
on that historical date.
