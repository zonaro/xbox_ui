import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xbox_ui/xbox_icon_button.dart';
import 'package:xbox_ui/xbox_menu.dart';

import 'xbox.dart';

class XboxDashboard extends StatefulWidget {
  const XboxDashboard({super.key, required this.child, required this.topBarItens, this.avatar, this.menu, required this.username, required this.userdetail});

  final List<Widget> topBarItens;

  final Widget child;

  final Widget? avatar;
  final XboxMenu? menu;
  final String username;
  final String userdetail;

  @override
  State<XboxDashboard> createState() => _XboxDashboardState();
}

class _XboxDashboardState extends State<XboxDashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    Xbox.tileWallpaperNotifier.addListener(() {
      setState(() {
        debugPrint("tile wallpaper changed");
      });
    });

    Xbox.userWallpaperNotifier.addListener(() {
      setState(() {
        debugPrint("user wallpaper changed");
      });
    });

    Xbox.accentColorNotifier.addListener(() {
      setState(() {
        debugPrint("color changed");
      });
    });

    super.initState();
  }

  _showHomeMenu() {
    debugPrint("showing home menu");
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.closeDrawer();
      } else {
        scaffoldKey.currentState!.openDrawer();
      }
    }
  }

  var keyboardNode = FocusNode(descendantsAreFocusable: true);

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: keyboardNode,
      onKeyEvent: keyEvents,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(
              key: ValueKey(Random().nextInt(9999)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: Xbox.tileWallpaper ?? Xbox.userWallpaper ?? Xbox.emptyImage, fit: BoxFit.cover, alignment: Alignment.center),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [Colors.transparent, Theme.of(context).colorScheme.background],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
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
                      backgroundColor: Xbox.accentColorNotifier.value,
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

  keyEvents(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.meta || event.logicalKey == (LogicalKeyboardKey.gameButtonMode) || event.logicalKey == (LogicalKeyboardKey.escape) || event.logicalKey == (LogicalKeyboardKey.goBack)) {
        _showHomeMenu();
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        keyboardNode.focusInDirection(TraversalDirection.down);
        return;
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        keyboardNode.focusInDirection(TraversalDirection.up);
        return;
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        keyboardNode.focusInDirection(TraversalDirection.left);
        return;
      }

        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        keyboardNode.focusInDirection(TraversalDirection.right);
        return;
      }
    }
  }
}
