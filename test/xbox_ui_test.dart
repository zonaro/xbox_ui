import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xbox_ui/xbox_colors.dart';
import 'package:xbox_ui/xbox_dashboard.dart';
import 'package:xbox_ui/xbox_icon_button.dart';
import 'package:xbox_ui/xbox_menu.dart';
import 'package:xbox_ui/xbox_mock.dart';
import 'package:xbox_ui/xbox_tile.dart';
import 'package:xbox_ui/xbox_tile_list.dart';
import 'package:xbox_ui/xbox_tile_view.dart';

void main() {
  testWidgets('Test XBOX UI', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const XboxMock());
  });
}

