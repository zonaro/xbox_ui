import 'package:flutter/material.dart';

class XboxFadeInRadialWallpaper extends StatefulWidget {
  final Widget wallpaper;

  const XboxFadeInRadialWallpaper({super.key, required this.wallpaper});

  @override
  createState() => _XboxFadeInRadialWallpaperState();
}

class _XboxFadeInRadialWallpaperState extends State<XboxFadeInRadialWallpaper> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    fadeIn();
  }

  void fadeIn() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            opacity: opacityLevel,
            duration: const Duration(seconds: 1),
            child: SizedBox(width: MediaQuery.of(context).size.width, child: widget.wallpaper),
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
      ),
    );
  }
}
