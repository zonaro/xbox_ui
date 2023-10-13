// ignore_for_file: non_constant_identifier_names

library xbox_ui;

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_colors.dart';

const double xboxTileRadius = 7;

typedef XboxMenuEntries = Map<String, void Function()?>;
typedef XboxApp = MaterialApp;

ThemeData get XboxDarkTheme => XboxColors.getTheme();
ThemeData get XboxLightTheme => XboxColors.getTheme(brightness: Brightness.light);

Color get xboxAccentColor => XboxColors.currentAccentColor;
  set xboxAccentColor(Color? color) => XboxColors.currentAccentColor = color ?? XboxColors.XboxGreen;
