// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xbox_ui/xbox_ui.dart';

/// `XboxTile` is a [Widget] that represents a tile in an Xbox-themed UI.
///
/// This widget displays an image, title, description, and an icon within a colored tile.
/// The width of the tile can be adjusted.
///
/// {@tool snippet}
///
/// Here is an example of how to use `XboxTile`:
///
/// ```dart
/// XboxTile(
///   color: Colors.green,
///   image: Image.network('url_to_image'),
///   title: 'Halo Infinite', // use when a tile is a game
///   description: 'Master Chief returns in Halo Infinite.', //use when a tile is a banner
///   icon: Icon(Icons.star),
///   width: 200.0,
/// )
/// ```
/// {@end-tool}
///
class XboxTile extends StatefulWidget {
  /// The color of the tile.
  final Color? tileColor;

  /// The image of the game. This is optional and can be null.
  final Widget? background;

  /// The title of the game. This is optional and can be null.
  final String title;

  /// A description for the tile. This is optional and can be null.
  final String description;

  /// An icon to display on the tile. This is optional and can be null.
  final Widget? icon;

  /// The width of the tile.
  final double width;

  /// The height of the tile.
  final double height;

  /// a double thats indicate how mutch a tile grow when in focus.
  final double growOnFocus;

  final bool autoFocus;

  final void Function()? onTap;

  final XboxMenuEntries? menuItems;

  const XboxTile({super.key, this.background, this.title = "", this.tileColor, this.growOnFocus = 0, this.icon, required this.width, this.description = "", this.onTap, required this.height, this.menuItems, required this.autoFocus});

  @override
  State<XboxTile> createState() => _XboxTileState();

  factory XboxTile.icon({required IconData icon, required String title, required double width, required double height, required double iconSize, double growOnFocus = 0, Color? color, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false}) => XboxTile(
        icon: Icon(icon, color: Colors.white, size: iconSize),
        autoFocus: autoFocus,
        title: title,
        width: width,
        height: height,
        tileColor: color ?? Xbox.currentAccentColor,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
      );

  factory XboxTile.flatColor({required Color backgroundColor, required String title, required double width, required double height, double growOnFocus = 0, Color? color, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false}) => XboxTile(
        background: Container(color: backgroundColor),
        onTap: onTap,
        autoFocus: autoFocus,
        menuItems: menuItems,
        title: title,
        width: width,
        height: height,
        growOnFocus: growOnFocus,
        tileColor: color ?? Xbox.currentAccentColor,
      );

  factory XboxTile.iconBanner({required IconData icon, required String description, required double width, required double height, required double iconSize, double growOnFocus = 0, Color? color, Widget? image, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false}) => XboxTile(
        icon: Icon(
          icon,
          color: Colors.white,
          size: iconSize,
          shadows: const [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              color: Colors.black,
              spreadRadius: 20,
              blurRadius: 35,
            )
          ],
        ),
        autoFocus: autoFocus,
        growOnFocus: growOnFocus,
        description: description,
        width: width,
        height: height,
        tileColor: color ?? Xbox.currentAccentColor,
        background: image,
        onTap: onTap,
        menuItems: menuItems,
      );

  factory XboxTile.iconGradient({required IconData icon, required String title, required double width, required double height, required double iconSize, required Gradient gradient, double growOnFocus = 0, Color? color, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false}) => XboxTile(
        icon: Icon(
          icon,
          color: Colors.white,
          size: iconSize,
          shadows: const [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              color: Colors.black,
              spreadRadius: 20,
              blurRadius: 35,
            )
          ],
        ),
        autoFocus: autoFocus,
        title: title,
        width: width,
        height: height,
        tileColor: color ?? Xbox.currentAccentColor,
        onTap: onTap,
        menuItems: menuItems,
        growOnFocus: growOnFocus,
        background: Container(decoration: BoxDecoration(gradient: gradient)),
      );

  factory XboxTile.banner({required String description, String title = "", required double width, required double height, required Widget image, Color? color, double growOnFocus = 0, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false, Widget? icon}) => XboxTile(
        autoFocus: autoFocus,
        background: image,
        description: description,
        width: width,
        height: height,
        tileColor: color ?? Xbox.currentAccentColor,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
        title: title,
        icon: icon,
      );

  factory XboxTile.game({required String title, required double width, required double height, required Widget image, Color? color, double growOnFocus = 0, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false}) => XboxTile(
        autoFocus: autoFocus,
        background: image,
        title: title,
        width: width,
        height: height,
        tileColor: color ?? Xbox.currentAccentColor,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
      );

  double getHeight(bool hasFocus) => growOnFocus > 0 && hasFocus ? height + (height * growOnFocus) : height;

  double getWidth(bool hasFocus) => growOnFocus > 0 && hasFocus ? width + (width * growOnFocus) : width;
}

class _XboxTileState extends State<XboxTile> {
  bool hasFocus = false;

  void _onFocus(bool value) {
    setState(() {
      hasFocus = value;
    });
  }

  _showMenu() async {
    _onFocus(true);
    if (widget.menuItems != null && widget.menuItems!.isNotEmpty) {
      await XboxDialog.menu(context, title: widget.title, menuEntries: widget.menuItems!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showTitleBox = hasFocus && widget.title.trim().isNotEmpty && widget.description.trim().isEmpty;

    final bool isBanner = widget.description.trim().isNotEmpty && !showTitleBox;

    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: hasFocus,
      onKeyEvent: (k) {
        if (k.logicalKey == LogicalKeyboardKey.gameButtonX) {
          _showMenu();
        }
      },
      child: GestureDetector(
        onTap: () {
          _onFocus(true);
          widget.onTap?.call();
        },
        onLongPress: _showMenu,
        child: FocusableActionDetector(
          descendantsAreFocusable: false,
          descendantsAreTraversable: false,
          onShowHoverHighlight: _onFocus,
          onShowFocusHighlight: _onFocus,
          autofocus: widget.autoFocus,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(2.5),
              width: getWidth(),
              height: getHeight(),
              decoration: hasFocus
                  ? BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      boxShadow: [
                        BoxShadow(
                          color: Xbox.currentAccentColor,
                          spreadRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(Xbox.TileRadius),
                    )
                  : null,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Xbox.TileRadius),
                    child: GridTile(
                      footer: !showTitleBox
                          ? null
                          : _SlideUpAnimationWrapper(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Xbox.TileRadius), bottomRight: Radius.circular(Xbox.TileRadius)),
                                child: Container(
                                  color: Colors.black.withOpacity(.8),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        widget.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: const Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color: Colors.black.withOpacity(.8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          Container(color: widget.tileColor ?? Xbox.currentAccentColor),
                          if (widget.background != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Xbox.TileRadius),
                              child: widget.background,
                            ),
                          Container(
                            decoration: isBanner ? const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.transparent, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter)) : null,
                            child: GridTile(
                                footer: isBanner
                                    ? Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (widget.title.trim().isNotEmpty)
                                                Text(
                                                  widget.title,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              if (widget.description.trim().isNotEmpty)
                                                Text(
                                                  widget.description,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : null,
                                child: Center(child: widget.icon)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getWidth() => widget.getWidth(hasFocus);
  double getHeight() => widget.getHeight(hasFocus);
}

class _SlideUpAnimationWrapper extends StatefulWidget {
  final Widget child;

  const _SlideUpAnimationWrapper({
    required this.child,
  });

  @override
  _SlideUpAnimationWrapperState createState() => _SlideUpAnimationWrapperState();
}

class _SlideUpAnimationWrapperState extends State<_SlideUpAnimationWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _offset = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
