// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:xbox_ui/xbox_tile.dart';

typedef XboxMenuEntries = Map<String, void Function()?>;
typedef XboxApp = MaterialApp;

extension Xbox on XboxApp {
  static const double TileRadius = 7;

  static ThemeData get DarkTheme => Xbox.getTheme();
  static ThemeData get LightTheme => Xbox.getTheme(brightness: Brightness.light);

  static final ValueNotifier<ImageProvider?> tileWallpaperNotifier = ValueNotifier(null);
  static final ValueNotifier<ImageProvider?> userWallpaperNotifier = ValueNotifier(null);

  static final ValueNotifier<Color> accentColorNotifier = ValueNotifier(Xbox.Green);

  static ThemeData getTheme({Brightness brightness = Brightness.dark}) => ThemeData(
        fontFamily: "SegoePro",
        package: "xbox_ui",
        fontFamilyFallback: const ["Arial"],
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: Xbox.accentColor,
          background: brightness == Brightness.dark ? Xbox.SlateGray : Colors.white,
          onBackground: brightness == Brightness.dark ? Colors.white : Xbox.SlateGray,
        ),
      );

  static const Green = Color(0xff107c10);

  static const SlateGray = Color(0xFF3A3A3A);

  static const TextStyle logoFont = TextStyle(fontFamily: "Xbox", package: 'xbox_ui');

  static TextStyle getFont({Color? color, FontWeight fontWeight = FontWeight.normal, double? fontSize}) => TextStyle(fontFamily: "SegoePro", fontWeight: fontWeight, package: 'xbox_ui', color: color, fontSize: fontSize);

  static Color get accentColor => accentColorNotifier.value;
  static set accentColor(Color? value) => accentColorNotifier.value = value ?? Xbox.Green;

  static ImageProvider? get tileWallpaper => tileWallpaperNotifier.value;
  static set tileWallpaper(ImageProvider? value) => tileWallpaperNotifier.value = value;

  static ImageProvider? get userWallpaper => userWallpaperNotifier.value;
  static set userWallpaper(ImageProvider? value) => userWallpaperNotifier.value = value;

  static Color getReadableColor([Color? color]) => (color ?? accentColor).computeLuminance() > 0.5 ? SlateGray : Colors.white;

  static Color getContrastThemeColor(BuildContext context) {
    var b = Theme.of(context).brightness;
    return b == Brightness.dark ? Colors.white : SlateGray;
  }

  static Color getBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? SlateGray : Colors.white;

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

  static BoxDecoration tileInFocus(BuildContext context, [Color? color]) => BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: color ?? Xbox.accentColor,
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

  Future<Size> getImageSize(Uint8List image) async {
    var decodedImage = await decodeImageFromList(image);
    return Size(decodedImage.width as double, decodedImage.height as double);
  }

  double calculateProportion(Size size) {
    return size.width / size.height;
  }
}
