import 'package:flutter/material.dart';

import 'package:xbox_ui/xbox_ui.dart';

void main() {
  // change this color will reflect the accent color of all xbox_ui components
  Xbox.accentColor = Xbox.Green; //change this

  runApp(
    XboxApp(
      themeMode: ThemeMode.dark,
      theme: Xbox.LightTheme, // getter for light and dark theme. apply the currentAccentColor to all tiles
      darkTheme: Xbox.DarkTheme,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Xbox.userWallpaper = const NetworkImage('https://picsum.photos/1000?a=888');
    super.initState();
  }

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
            growOnFocus: 1,
          ),
          XboxTile.icon(
            icon: Icons.usb_rounded,
            title: "Devices",
            size: const Size.square(60),
            growOnFocus: 1,
          ),
        ]),
        XboxTileList(title: "Game Style", tiles: [
          XboxTile.game(
            title: "Game Name",
            size: const Size.square(200),
            dashboardWallpaper: const NetworkImage(
              'https://picsum.photos/200/100?a=11',
            ),
            image: const NetworkImage('https://picsum.photos/100/100?a=1'),
          ),
        ]),
        XboxTileList(title: "Banner", tiles: [
          XboxTile.banner(
            title: "Game Collection",
            icon: Icons.games,
            description: "Banner with multiple images and a icon",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 200),
            images: const [
              NetworkImage('https://picsum.photos/200/?b=2'),
              NetworkImage('https://picsum.photos/200/?b=3'),
              NetworkImage('https://picsum.photos/200/?b=4'),
              NetworkImage('https://picsum.photos/200/?b=5'),
              NetworkImage('https://picsum.photos/200/?b=6'),
              NetworkImage('https://picsum.photos/200/?b=7'),
            ],
          ),
          XboxTile.banner(
            description: "A short banner with just description",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 200),
            images: const [NetworkImage('https://picsum.photos/200/120?a=2')],
          ),
          XboxTile.banner(
            description: "Sometimes we have icons",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 200),
            images: const [NetworkImage('https://picsum.photos/200/120?a=3')],
            icon: Icons.gamepad,
          ),
        ]),
        XboxTileList(title: "Icon Gradient", tiles: [
          XboxTile.iconGradient(
            title: "A Gradient background with Icon",
            size: Xbox.getSizeFromAspectRatio(16 / 9, height: 120),
            icon: Icons.color_lens,
            gradient: LinearGradient(colors: [Colors.purple[700]!, Colors.blue[800]!]),
          ),
          XboxTile.iconGradient(
            title: "Food",
            size: Xbox.getSizeFromAspectRatio(8 / 12, height: 120),
            icon: Icons.fastfood,
            gradient: LinearGradient(colors: [Colors.red[700]!, Colors.yellow[800]!]),
          ),
        ]),
        XboxTileList(title: "Colors", tiles: Xbox.colorTiles(Colors.primaries, onTap: (x) => Xbox.accentColor = x))
      ]),
    );
  }
}
