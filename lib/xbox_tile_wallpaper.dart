import 'package:flutter/material.dart';

class XboxFadeInRadialWallpaper extends StatefulWidget {
  final Widget? newTileWallpaper;
  final Widget? oldTileWallpaper;
  final Widget? dashboardWallpaper;

  const XboxFadeInRadialWallpaper({super.key, required this.newTileWallpaper, required this.dashboardWallpaper, this.oldTileWallpaper});

  @override
  createState() => _XboxFadeInRadialWallpaperState();
}

class _XboxFadeInRadialWallpaperState extends State<XboxFadeInRadialWallpaper> {
  @override
  Widget build(BuildContext context) {
    var duration = const Duration(seconds: 3);
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedCrossFade(
          firstChild: ((widget.oldTileWallpaper ?? widget.dashboardWallpaper) == null) ? const SizedBox.shrink() : SizedBox.expand(child: widget.oldTileWallpaper ?? widget.dashboardWallpaper),
          secondChild: ((widget.newTileWallpaper ?? widget.dashboardWallpaper) == null) ? const SizedBox.shrink() : SizedBox.expand(child: widget.oldTileWallpaper ?? widget.dashboardWallpaper),
          crossFadeState: widget.newTileWallpaper != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: duration,
        ),
        AnimatedCrossFade(
          duration: duration,
          crossFadeState: widget.newTileWallpaper == null && widget.oldTileWallpaper == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [Colors.transparent, Theme.of(context).colorScheme.background],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
