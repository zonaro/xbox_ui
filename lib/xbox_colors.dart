// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
 
import 'package:/xbox_tile.dart';

mixin XboxColors {
  static ThemeData getTheme( ) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: XboxColors.currentAccentColor, background: XboxColors.GrayBackground),
      ).copyWith(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      );

  static const XboxGreen = Color(0xFF0e7a0d);
  static const GrayBackground = Color(0xFF2E2E2E);
  static const XboxGray = Color(0xFF444444);

  static Color currentAccentColor = XboxColors.XboxGreen;

  static List<XboxTile> colorTiles(List<Color> colors, {double width = 50, double height = 50, void Function(Color)? onTap}) => colors
      .map(
        (c) => XboxTile.flatColor(
          onTap: onTap != null
              ? () {
                  onTap(c);
                }
              : null,
          backgroundColor: c,
          title: c.hexadecimal,
          width: width,
          height: height,
        ),
      )
      .toList();
}
