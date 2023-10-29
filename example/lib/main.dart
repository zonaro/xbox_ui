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
          size: 20,
          icon: Icons.music_note,
          onPressed: () {
            XboxNotification(title: "Playing...").show(context);
          },
        ),
        XboxCircleButton.icon(
          size: 20,
          icon: Icons.book,
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
          size: 20,
          icon: Icons.cancel,
          onPressed: () {
            XboxDialog.confirm(context);
          },
        ),
        XboxCircleButton.icon(
          size: 20,
          icon: Icons.numbers,
          onPressed: () async {
            var v = XboxDialog.loadingBar(context, title: 'Loading...', description: "Waiting for completion");

            await Future.doWhile(() => Future.delayed(const Duration(milliseconds: 50)).then((_) => !v.increaseValue(.01))).then((value) => Navigator.pop(context));
          },
        ),
      ],
      child: XboxTileView(items: [
        XboxTileList(title: "Game Style", tiles: [
          XboxTile.game(
            title: "Game Name",
            size: const Size.square(150),
            dashboardWallpaper: const NetworkImage(
              'https://picsum.photos/200/100?a=11',
            ),
            growOnFocus: .5,
            image: const NetworkImage('https://picsum.photos/100/100?a=1'),
          ),
          XboxTile.game(
            title: "Game Name 2",
            growOnFocus: .5,
            upperText: "Demo version",
            size: const Size.square(150),
            dashboardWallpaper: const NetworkImage(
              'https://picsum.photos/200/100?a=13',
            ),
            image: const NetworkImage('https://picsum.photos/100/100?a=11657'),
          ),
          XboxTile.game(
            growOnFocus: .5,
            title: "Game Name 3",
            size: const Size.square(150),
            bottomLeftIcon: Icons.abc,
            bottomRightIcon: Icons.gamepad,
            dashboardWallpaper: const NetworkImage(
              'https://picsum.photos/200/100?a=13',
            ),
            image: const NetworkImage('https://picsum.photos/100/100?a=568'),
          ),
        ]),
        XboxTileList(title: "Icons with default accent color", tiles: [
          XboxTile.icon(
            icon: Icons.settings,
            title: "Settings",
            size: const Size.square(100),
   
          ),
          XboxTile.icon(
            icon: Icons.usb_rounded,
            title: "Devices",
            size: const Size.square(100),
    
          ),
        ]),
        XboxTileList(title: "Button Style", tiles: [
          XboxTile.button(
            title: "CONFIRM",
            icon: Icons.gamepad_outlined,
            onTap: () => XboxDialog.confirm(context),
          ),
          XboxTile.button(
            title: "BUTTON 02",
            icon: Icons.settings,
          ),
          XboxTile.button(
            title: "BUTTON 03",
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

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Xbox.SlateGray,
        body: Column(
          children: [
            const Text('Title', style: TextStyle(color: Xbox.White, fontSize: 24)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Tab 1', style: TextStyle(color: Xbox.White)),
                Text('Tab 2', style: TextStyle(color: Xbox.White)),
                Text('Tab 3', style: TextStyle(color: Xbox.White)),
              ],
            ),
            const Text('Sort Field', style: TextStyle(color: Xbox.White)),
            const Text('Filters Menu', style: TextStyle(color: Xbox.White)),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: const [
                        ListTile(title: Text('Games', style: TextStyle(color: Xbox.White))),
                        ListTile(title: Text('Apps', style: TextStyle(color: Xbox.White))),
                        ListTile(title: Text('Full Library', style: TextStyle(color: Xbox.White))),
                        ListTile(title: Text('Queue', style: TextStyle(color: Xbox.White))),
                        ListTile(title: Text('Update', style: TextStyle(color: Xbox.White))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return XboxTile.game(
                          title: "Game Name",
                          size: const Size.square(200),
                          dashboardWallpaper: const NetworkImage('https://picsum.photos/200/100?a=11'),
                          image: const NetworkImage('https://picsum.photos/100/100?a=1'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
