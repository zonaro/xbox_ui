import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_achievement.dart';
import 'package:xbox_ui/xbox_dashboard.dart';
import 'package:xbox_ui/xbox_icon_button.dart';
import 'package:xbox_ui/xbox_menu.dart';
import 'package:xbox_ui/xbox_popup_menu.dart';
import 'package:xbox_ui/xbox_tile.dart';
import 'package:xbox_ui/xbox_tile_list.dart';
import 'package:xbox_ui/xbox_tile_view.dart';

class XboxMock extends StatefulWidget {
  const XboxMock({
    super.key,
  });

  @override
  State<XboxMock> createState() => _XboxMockState();
}

class _XboxMockState extends State<XboxMock> {
  @override
  Widget build(BuildContext context) => XboxDashboard(
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
              XboxDialog.menu(
                context,
                title: "Book Menu",
                menuEntries: {
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
      );
}
