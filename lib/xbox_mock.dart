import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_achievement.dart';
import 'package:xbox_ui/xbox_dashboard.dart';
import 'package:xbox_ui/xbox_icon_button.dart';
import 'package:xbox_ui/xbox_menu.dart';
import 'package:xbox_ui/xbox_popup_menu.dart';
import 'package:xbox_ui/xbox_tile.dart';
import 'package:xbox_ui/xbox_tile_list.dart';
import 'package:xbox_ui/xbox_tile_view.dart';
import 'package:xbox_ui/xbox_ui.dart';

class XboxMock extends StatelessWidget {
  const XboxMock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XboxApp(
        title: 'Xbox Demo',
        themeMode: ThemeMode.system,
        theme: XboxLightTheme,
        darkTheme: XboxDarkTheme,
        home: XboxDashboard(
          username: 'XboxUser',
          userdetail: '1234 points',
          menu: const XboxMenu(
            items: [
              ListTile(title: Text("First")),
              ListTile(title: Text("Second")),
              ListTile(title: Text("Third")),
            ],
          ),
          topBarItens: [
            XboxCircleButton.icon(
              20,
              Icons.music_note,
              onPressed: () {
                XboxAchievement(title: "Got a Song").show(context);
              },
            ),
            XboxCircleButton.icon(
              20,
              Icons.book,
              onPressed: () {
                XboxPopupMenu.showMenu(
                  context,
                  title: "Book Menu",
                  menuItems: {
                    "Book 1": () {
                      XboxAchievement(title: "Got book 1", color: Colors.yellow).show(context);
                    },
                    "Book 2": () {
                      XboxAchievement(title: "Got book 2").show(context);
                    },
                  },
                );
              },
            ),
            XboxCircleButton.icon(
              20,
              Icons.access_time_filled_outlined,
              onPressed: () {},
            ),
            XboxCircleButton.icon(
              20,
              Icons.settings,
              onPressed: () {},
            ),
          ],
          child: XboxTileView(items: [
            XboxTileList(tiles: [
              XboxTile.icon(
                icon: Icons.settings,
                title: "Settings",
                width: 100,
                height: 100,
                iconSize: 30,
                growOnFocus: .5,
              ),
              XboxTile.icon(
                icon: Icons.usb_rounded,
                title: "Devices",
                width: 100,
                height: 100,
                iconSize: 30,
                growOnFocus: .5,
              ),
            ]),
            // XboxTileList(tiles: [
            //   XboxTile.game(title: "Game Name", width: 100, height: 100, image: Image.network('https://picsum.photos/id/1/200/300')),
            // ]),
          ]),
        ));
  }
}
