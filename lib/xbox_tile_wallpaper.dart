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
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(seconds: 1);
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AnimatedCrossFade(
            firstChild: widget.oldTileWallpaper ?? widget.dashboardWallpaper ?? const SizedBox.shrink(),
            secondChild: widget.newTileWallpaper ?? widget.dashboardWallpaper ?? const SizedBox.shrink(),
            crossFadeState: widget.newTileWallpaper != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: duration,
          ),
        ),
        if (widget.newTileWallpaper != null)
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
