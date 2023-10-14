import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_ui.dart';

void main() {
  Xbox.currentAccentColor = Xbox.Green; //change this

  runApp(
    XboxApp(
      themeMode: ThemeMode.dark,
      theme: Xbox.LightTheme, // getter for light and dark theme. apply the currentAccentColor to all tiles
      darkTheme: Xbox.DarkTheme,
      home: const BasicXboxUi(),
    ),
  );
}

class BasicXboxUi extends StatefulWidget {
  const BasicXboxUi({super.key});

  @override
  State<BasicXboxUi> createState() => _BasicXboxUiState();
}

class _BasicXboxUiState extends State<BasicXboxUi> {
  @override
  Widget build(BuildContext context) {
    return XboxDashboard(
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
        XboxTileList(title: "Icons with default accent color and growing on focus", tiles: [
          XboxTile.icon(
            icon: Icons.settings,
            title: "Settings",
            size: const Size.square(60),
            iconSize: 30,
            growOnFocus: 1,
          ),
          XboxTile.icon(
            icon: Icons.usb_rounded,
            title: "Devices",
            size: const Size.square(60),
            iconSize: 30,
            growOnFocus: 1,
          ),
        ]),
        XboxTileList(title: "Game Style", tiles: [
          XboxTile.game(
            title: "Game Name",
            size: const Size.square(200),
            dashboardWallpaper: Image.network(
              'https://picsum.photos/100/100?a=1',
              fit: BoxFit.cover,
            ),
            image: Image.network(
              'https://picsum.photos/100/100?a=1',
              fit: BoxFit.cover,
            ),
          ),
        ]),
        XboxTileList(title: "Banner", tiles: [
          XboxTile.banner(
            title: "Banner Title",
            description: "A short banner description",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 200),
            image: Image.network(
              'https://picsum.photos/200/120?a=2',
              fit: BoxFit.cover,
            ),
          ),
          XboxTile.iconBanner(
            description: "Sometimes we have icons",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 200),
            image: Image.network(
              'https://picsum.photos/200/120?a=3',
              fit: BoxFit.cover,
            ),
            iconSize: 60,
            icon: Icons.gamepad,
          ),
        ]),
        XboxTileList(title: "Icon Gradient", tiles: [
          XboxTile.iconGradient(
            title: "A Gradient background with Icon",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 120),
            icon: Icons.color_lens,
            gradient: LinearGradient(colors: [Colors.purple[700]!, Colors.blue[800]!]),
            dashboardWallpaper: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple[700]!, Colors.blue[800]!]))),
            iconSize: 60,
          ),
        ]),
        XboxTileList(title: "Colors", tiles: Xbox.colorTiles(Colors.primaries, onTap: (x) => setState(() => Xbox.currentAccentColor = x)))
      ]),
    );
  }
}
