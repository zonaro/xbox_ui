import 'package:flutter/material.dart';
import 'dart:math' as math;

class XboxUiLogo extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color color;
  final String text;
  final double rotation;

  const XboxUiLogo({
    super.key,
    required this.iconData,
    required this.size,
    required this.color,
    required this.text,
    this.rotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: ShaderMask(
            blendMode: BlendMode.srcOut,
            shaderCallback: (bounds) => LinearGradient(colors: [color], stops: const [0.0]).createShader(bounds),
            child: Transform.rotate(
              angle: rotation * math.pi / 180,
              child: Icon(
                iconData,
                size: size,
                color: color,
              ),
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            
            fontSize: size * 0.8,
            fontFamily: 'Xbox',
            package: 'xbox_ui',
            color: color,
          ),
        ),
      ],
    );
  }
}
