// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:convert';
 

import 'package:flutter/material.dart';

import 'package:xbox_ui/xbox_tile.dart';

typedef XboxMenuEntries = Map<String, void Function()?>;
typedef XboxApp = MaterialApp;

extension Xbox on MaterialApp {
  static const double TileRadius = 7;

  static ThemeData get DarkTheme => Xbox.getTheme();
  static ThemeData get LightTheme => Xbox.getTheme(brightness: Brightness.light);

  static final ValueNotifier<ImageProvider?> tileWallpaperNotifier = ValueNotifier(null);
  static final ValueNotifier<ImageProvider?> userWallpaperNotifier = ValueNotifier(null);
  static final ValueNotifier<Color> accentColorNotifier = ValueNotifier(Xbox.Green);

  static ThemeData getTheme({Brightness brightness = Brightness.dark}) => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: Xbox.accentColorNotifier.value, background: brightness == Brightness.dark ? Xbox.SlateGray : Xbox.White),
      );

  static const Green = Color(0xFF107C10);

  static const SlateGray = Color(0xFF3A3A3A);

  static const White = Color(0xFFEEEEEE);

  static TextStyle get XboxFont => const TextStyle(fontFamily: "Xbox");

  static Color get accentColor => accentColorNotifier.value;
  static set accentColor(Color? value) => accentColorNotifier.value = value ?? Xbox.Green;

  static ImageProvider? get tileWallpaper => tileWallpaperNotifier.value;
  static set tileWallpaper(ImageProvider? value) => tileWallpaperNotifier.value = value;

  static ImageProvider? get userWallpaper => userWallpaperNotifier.value;
  static set userWallpaper(ImageProvider? value) => userWallpaperNotifier.value = value;

  static Color getReadableColor([Color? color]) => (color ?? accentColorNotifier.value).computeLuminance() > 0.5 ? Colors.black : Colors.white;

  static Color getContrastThemeColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? White : SlateGray;

  static Color getBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? SlateGray : White;

  static RoundedRectangleBorder get defaultBorderShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(Xbox.TileRadius));

  static List<XboxTile> colorTiles(List<Color> colors, {Size size = const Size.square(100), void Function(Color)? onTap}) => colors
      .map(
        (c) => XboxTile.flatColor(
          onTap: onTap != null
              ? () {
                  onTap(c);
                }
              : null,
          backgroundColor: c,
          title: c.value.toRadixString(16).padLeft(8, '0'),
          size: size,
        ),
      )
      .toList();

  static BoxDecoration tileInFocus(BuildContext context) => BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Xbox.accentColorNotifier.value,
            spreadRadius: 2.0,
          ),
        ],
        borderRadius: BorderRadius.circular(Xbox.TileRadius),
      );

  /// Help calculate and create [XboxTile] based on aspect ratio
  static Size getSizeFromAspectRatio(double aspectRatio, {double? width, double? height}) {
    if (width == null && height == null) {
      width = aspectRatio * 100;
      height = 100;
    } else if (width != null && height == null) {
      height = width / aspectRatio;
    } else if (height != null && width == null) {
      width = height * aspectRatio;
    }
    return Size(width!, height!);
  }

  /// Help calculate and create [XboxTile] based on aspect ratio
  static Size getSizeFromAspectRatioString(String aspectRatio, {double? width, double? height}) {
    var ratio = aspectRatio.split(':').map((e) => double.parse(e)).toList();
    return getSizeFromAspectRatio(ratio.first / ratio.last);
  }

  static final ImageProvider emptyImage = MemoryImage(const Base64Codec().decode("R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"));
}
