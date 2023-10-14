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
    var first = widget.oldTileWallpaper ?? widget.dashboardWallpaper ?? Placeholder();
    var second = widget.newTileWallpaper ?? widget.dashboardWallpaper ?? Placeholder();

    var duration = const Duration(seconds: 3);
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedCrossFade(
          firstChild: first,
          secondChild: second,
          crossFadeState: CrossFadeState.showSecond,
          duration: duration,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0,
              colors: [Colors.transparent, Theme.of(context).colorScheme.background],
              stops: const [0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
