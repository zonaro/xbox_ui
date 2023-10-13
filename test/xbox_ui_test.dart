import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xbox_ui/xbox_colors.dart';
import 'package:xbox_ui/xbox_dashboard.dart';
import 'package:xbox_ui/xbox_icon_button.dart';
import 'package:xbox_ui/xbox_tile.dart';
import 'package:xbox_ui/xbox_tile_list.dart';
import 'package:xbox_ui/xbox_tile_view.dart';

void main() {
  testWidgets('Test XBOX UI', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const XboxTester());
  });
}

class XboxTester extends StatelessWidget {
  const XboxTester({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: XboxColors.getTheme(),
        home: XboxDashboard(
          topBarItens: const [
            XboxIconButton(icon: Icon(Icons.music_note)),
            XboxIconButton(icon: Icon(Icons.book)),
            XboxIconButton(icon: Icon(Icons.access_time_filled_outlined)),
            XboxIconButton(icon: Icon(Icons.settings)),
          ],
          userdetail: 'XboxUser',
          username: '1234 points',
          child: XboxTileView(items: [
            XboxTileList(tiles: [
              XboxTile.icon(icon: Icons.settings, title: "Settings", width: 100, height: 100, iconSize: 30),
              XboxTile.icon(icon: Icons.usb_rounded, title: "Devices", width: 100, height: 100, iconSize: 30),
            ]),
            // XboxTileList(tiles: [
            //   XboxTile.game(title: "Game Name", width: 100, height: 100, image: Image.network('https://picsum.photos/id/1/200/300')),
            // ]),
          ]),
        ));
  }
}
