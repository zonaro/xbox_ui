// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:xbox_ui/xbox_tile.dart';

mixin XboxColors {
  static ThemeData getTheme({Brightness brightness = Brightness.dark}) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: XboxColors.currentAccentColor, background: brightness == Brightness.dark ? XboxColors.SlateGray : XboxColors.White),
      );

  static const XboxGreen = Color(0xFF107C10);

  static const SlateGray = Color(0xFF3A3A3A);

  static const White = Color(0xFFEEEEEE);

  static Color currentAccentColor = XboxColors.XboxGreen;

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? White : SlateGray;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? SlateGray : White;
  }

  static List<XboxTile> colorTiles(List<Color> colors, {double width = 50, double height = 50, void Function(Color)? onTap}) => colors
      .map(
        (c) => XboxTile.flatColor(
          onTap: onTap != null
              ? () {
                  onTap(c);
                }
              : null,
          backgroundColor: c,
          title: c.value.toRadixString(16).padLeft(8, '0'),
          width: width,
          height: height,
        ),
      )
      .toList();
}
