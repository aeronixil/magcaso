import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

@immutable
class ArModel {
  const ArModel({
    required this.id,
    required this.title,
    required this.description,
    required this.source,
    this.iosSource,
  });

  final String id;
  final String title;
  final String description;
  final String source;
  final String? iosSource;
}

const arModels = [
  ArModel(
    id: 'astronaut',
    title: 'Astronaut',
    description:
        'Explore a spacesuit in 3D, then place the astronaut in your room.',
    source: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    iosSource: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
  ),
  ArModel(
    id: 'robot',
    title: 'Expressive robot',
    description:
        'Rotate and zoom the animated robot, or view it at room scale.',
    source: 'https://modelviewer.dev/shared-assets/models/RobotExpressive.glb',
  ),
];

typedef ArViewerBuilder = Widget Function(
  BuildContext context,
  ArModel model,
  bool autoRotate,
);

class ArGalleryPage extends StatefulWidget {
  const ArGalleryPage({super.key, this.viewerBuilder});

  /// Tests can inject a viewer without a device WebView or a network connection.
  final ArViewerBuilder? viewerBuilder;

  @override
  State<ArGalleryPage> createState() => _ArGalleryPageState();
}

class _ArGalleryPageState extends State<ArGalleryPage> {
  ArModel _model = arModels.first;
  bool _autoRotate = true;
  int _reload = 0;

  Widget _viewer(BuildContext context) {
    if (widget.viewerBuilder != null) {
      return widget.viewerBuilder!(context, _model, _autoRotate);
    }
    final supported =
        kIsWeb ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
    if (!supported) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Open the web app in a browser for 3D viewing, or use an Android '
            'or iOS device for supported AR experiences.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ModelViewer(
      key: ValueKey('${_model.id}-$_reload-$_autoRotate'),
      src: _model.source,
      iosSrc: _model.iosSource,
      alt: _model.description,
      ar: true,
      arModes: const ['scene-viewer', 'webxr', 'quick-look'],
      cameraControls: true,
      autoRotate: _autoRotate,
      autoPlay: true,
      backgroundColor: const Color(0xFFF0F3FA),
      relatedJs: kIsWeb
          ? null
          : """
        const viewer = document.querySelector('model-viewer');
        const status = document.getElementById('model-status');
        viewer.addEventListener('error', () => {
          status.textContent = 'Model could not load. Check your connection, then tap Reload.';
          status.style.display = 'block';
        });
        viewer.addEventListener('load', () => { status.style.display = 'none'; });
        viewer.addEventListener('ar-status', (event) => {
          if (event.detail.status === 'failed') {
            status.textContent = 'AR could not start. Check device support and camera access.';
            status.style.display = 'block';
          }
        });
      """,
      innerModelViewerHtml: kIsWeb
          ? null
          : """
        <div id="model-status" role="status" aria-live="polite"
          style="position:absolute;top:12px;left:12px;right:12px;padding:12px;
          background:white;color:#172033;border-radius:8px;font:14px sans-serif">
          Loading 3D model…
        </div>
      """,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('3D & AR studio')),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Bring a model into your space',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              for (final model in arModels)
                ChoiceChip(
                  label: Text(model.title),
                  selected: _model.id == model.id,
                  onSelected: (_) => setState(() => _model = model),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(_model.description),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height < 700 ? 300 : 420,
              child: _viewer(context),
            ),
          ),
          Wrap(
            spacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Auto rotate'),
                  Switch(
                    value: _autoRotate,
                    onChanged: (value) => setState(() => _autoRotate = value),
                  ),
                ],
              ),
              TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Reload model'),
                onPressed: () => setState(() => _reload++),
              ),
            ],
          ),
          const Text(
            'Drag to rotate and pinch or scroll to zoom. On a supported phone, '
            'tap the AR button inside the viewer, allow camera access, and scan '
            'a well-lit floor or table to place the model.',
          ),
          const SizedBox(height: 12),
          const Text(
            'Models require an internet connection. AR availability depends on '
            'your device and browser; desktop browsers provide 3D viewing. '
            'Web AR requires HTTPS. Android uses Scene Viewer / ARCore; iOS '
            'uses Quick Look, which may be unavailable in embedded browsers. '
            'The astronaut includes a dedicated iOS USDZ model.',
          ),
          const SizedBox(height: 12),
          Text(
            'Sample models: modelviewer.dev · Astronaut by Poly (CC BY 2.0), '
            'RobotExpressive by Tomás Laulhé (CC0). See docs/AR.md for source links.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}
