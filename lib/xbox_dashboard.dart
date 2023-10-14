import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xbox_ui/xbox_icon_button.dart';
import 'package:xbox_ui/xbox_menu.dart';
import 'package:xbox_ui/xbox_tile_wallpaper.dart';

import 'xbox.dart';

class XboxDashboard extends StatefulWidget {
  const XboxDashboard({super.key, required this.child, required this.topBarItens, this.wallpaper, this.avatar, this.menu, required this.username, required this.userdetail});

  final List<Widget> topBarItens;

  final Widget child;
  final Widget? wallpaper;
  final Widget? avatar;
  final XboxMenu? menu;
  final String username;
  final String userdetail;

  @override
  State<XboxDashboard> createState() => _XboxDashboardState();
}

class _XboxDashboardState extends State<XboxDashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _showHomeMenu() {
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.closeDrawer();
      } else {
        scaffoldKey.currentState!.openDrawer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(descendantsAreFocusable: true),
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.gameButtonMode) || event.isKeyPressed(LogicalKeyboardKey.escape)) {
            _showHomeMenu();
          }
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (Xbox.tileWallpaper != null) XboxFadeInRadialWallpaper(wallpaper: Xbox.tileWallpaper!) else if (widget.wallpaper != null) SizedBox(width: MediaQuery.of(context).size.width, child: widget.wallpaper),
          Scaffold(
            key: scaffoldKey,
            backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.7),
            drawer: widget.menu,
            extendBody: true,
            appBar: AppBar(
              centerTitle: true,
              surfaceTintColor: Colors.transparent,
              leadingWidth: MediaQuery.of(context).size.width * 0.3,
              automaticallyImplyLeading: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Wrap(
                  spacing: 10,
                  children: [
                    XboxCircleButton(
                      onPressed: () => _showHomeMenu(),
                      size: 50,
                      backgroundColor: Xbox.currentAccentColor,
                      child: widget.avatar ?? const Icon(Icons.person),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            maxLines: 1,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            widget.userdetail,
                            maxLines: 1,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              toolbarHeight: 85,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              title: SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.topBarItens,
                ),
              ),
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                )
              ],
            ),
            body: widget.child,
          ),
        ],
      ),
    );
  }
}
