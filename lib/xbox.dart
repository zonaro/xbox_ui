// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:xbox_ui/xbox_tile.dart';

typedef XboxMenuEntries = Map<String, void Function()?>;

typedef XboxApp = MaterialApp;

extension Xbox on MaterialApp {
  
  static const double TileRadius = 7;

  static ThemeData get DarkTheme => Xbox.getTheme();
  static ThemeData get LightTheme => Xbox.getTheme(brightness: Brightness.light);

  Color get xboxAccentColor => Xbox.currentAccentColor;
  set xboxAccentColor(Color? color) => Xbox.currentAccentColor = color ?? Xbox.Green;

  static ThemeData getTheme({Brightness brightness = Brightness.dark}) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: Xbox.currentAccentColor, background: brightness == Brightness.dark ? Xbox.SlateGray : Xbox.White),
      );

  static const Green = Color(0xFF107C10);

  static const SlateGray = Color(0xFF3A3A3A);

  static const White = Color(0xFFEEEEEE);

  static TextStyle get XboxFont => const TextStyle(fontFamily: "Xbox");

  static Color currentAccentColor = Green;

  static Color getReadableColor([Color? color]) => (color ?? currentAccentColor).computeLuminance() > 0.5 ? Colors.black : Colors.white;

  static Color getContrastThemeColor(BuildContext context) {
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
