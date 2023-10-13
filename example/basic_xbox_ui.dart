import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_ui.dart';

class BasicXboxUi extends StatefulWidget {
  const BasicXboxUi({super.key});

  @override
  State<BasicXboxUi> createState() => _BasicXboxUiState();
}

class _BasicXboxUiState extends State<BasicXboxUi> {
  @override
  Widget build(BuildContext context) {
    return XboxApp(
      themeMode: ThemeMode.system,
      theme: Xbox.LightTheme,
      darkTheme: Xbox.DarkTheme,
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
              XboxNotification(title: "Playing...").show(context);
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
                  "Yellow Book": () {
                    XboxNotification(title: "Book 1", color: Colors.yellow).show(context);
                  },
                  "Book": () {
                    XboxNotification(title: "Book 2").show(context);
                  },
                },
              );
            },
          ),
          XboxCircleButton.icon(
            20,
            Icons.cancel,
          ),
          XboxCircleButton.icon(
            20,
            Icons.settings,
            onPressed: () {},
          ),
        ],
        child: XboxTileView(items: [
          XboxTileList(title: "Icons", tiles: [
            XboxTile.icon(
              icon: Icons.settings,
              title: "Settings",
              width: 60,
              height: 60,
              iconSize: 30,
              growOnFocus: .5,
            ),
            XboxTile.icon(
              icon: Icons.usb_rounded,
              title: "Devices",
              width: 60,
              height: 60,
              iconSize: 30,
              growOnFocus: .5,
            ),
          ]),
          XboxTileList(title: "Game Style", tiles: [
            XboxTile.game(title: "Game Name", width: 100, height: 100, image: Image.network('https://picsum.photos/id/1/200/300')),
          ]),
          XboxTileList(title: "Banner", tiles: [
            XboxTile.banner(title: "Banner Title", description: "A short banner description", width: 200, height: 120, image: Image.network('https://picsum.photos/id/1/200/300')),
            XboxTile.banner(description: "Sometimes we have icons", width: 200, height: 120, image: Image.network('https://picsum.photos/id/1/200/300')),
          ]),
          XboxTileList(title: "Icon Gradient", tiles: [
            XboxTile.iconGradient(
              title: "A Gradient Icon",
              width: 200,
              height: 120,
              icon: Icons.color_lens,
              gradient: LinearGradient(colors: [Colors.purple[700]!, Colors.blue[800]!]),
              iconSize: 60,
            ),
          ]),
        ]),
      ),
    );
  }
}
