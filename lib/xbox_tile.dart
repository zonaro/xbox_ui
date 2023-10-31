// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xbox_ui/xbox_stacker.dart';
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
///   image: NetworkImage('url_to_image'),
///   title: 'Halo Infinite', // use when a tile is a game
///   description: 'Master Chief returns in Halo Infinite.', //use when a tile is a banner
///   icon: Icon(Icons.star),
///   width: 200.0,
/// )
/// ```
/// {@end-tool}
///
class XboxTile extends StatefulWidget {
  /// an image that show up on dashboard background when this tile widget is in focus
  final ImageProvider? dashboardWallpaper;

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

  final Size size;

  /// a double thats indicate how mutch a tile grow when in focus.
  final double growOnFocus;

  final bool autoFocus;

  final bool fixedFocus;

  final void Function()? onTap;

  final XboxMenuEntries? menuItems;

  final String upperText;

  final Widget? bottomLeftIcon;
  final Widget? bottomRightIcon;

  const XboxTile({super.key, this.background, this.title = "", this.tileColor, this.growOnFocus = 0, this.icon, required this.size, this.description = "", this.onTap, this.menuItems, this.autoFocus = false, this.dashboardWallpaper, this.upperText = '', this.bottomLeftIcon, this.bottomRightIcon, this.fixedFocus = false});

  @override
  State<XboxTile> createState() => _XboxTileState();

  factory XboxTile.button({IconData? icon, required String title, Size size = const Size(280, 120), Color? color, bool autoFocus = false, void Function()? onTap}) {
    return XboxTile(
      size: size,
      autoFocus: autoFocus,
      description: title, //title do button é a description mesmo
      tileColor: color,
      onTap: onTap,
      icon: icon != null
          ? LayoutBuilder(
              builder: (context, constraints) => Icon(
                icon,
                color: Xbox.getReadableColor().withOpacity(.6),
                size: constraints.maxHeight * .35,
              ),
            )
          : null,
    );
  }

  factory XboxTile.icon({required IconData icon, required String title, required Size size, double growOnFocus = 0, Color? color, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false, ImageProvider? dashboardWallpaper}) => XboxTile(
        icon: LayoutBuilder(builder: (context, constraints) {
          return Icon(
            icon,
            color: Xbox.getReadableColor(),
            size: constraints.maxHeight * .5,
          );
        }),
        autoFocus: autoFocus,
        title: title,
        tileColor: color,
        onTap: onTap,
        dashboardWallpaper: dashboardWallpaper,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
        size: size,
      );

  factory XboxTile.flatColor({required Color backgroundColor, String title = "", required Size size, double growOnFocus = 0, Color? color, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false, ImageProvider? dashboardWallpaper}) => XboxTile(
        background: Container(width: size.width, height: size.height, color: backgroundColor),
        onTap: onTap,
        autoFocus: autoFocus,
        menuItems: menuItems,
        title: title,
        size: size,
        growOnFocus: growOnFocus,
        dashboardWallpaper: dashboardWallpaper,
        tileColor: color,
      );

  factory XboxTile.banner({IconData? icon, required String description, String title = "", required Size size, double growOnFocus = 0, Color? color, List<ImageProvider?> images = const [], void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false, ImageProvider? dashboardWallpaper}) => XboxTile(
        icon: icon != null
            ? LayoutBuilder(builder: (context, constraints) {
                return Icon(
                  icon,
                  color: Colors.white,
                  size: constraints.maxHeight * .5,
                  shadows: const [
                    BoxShadow(
                      blurStyle: BlurStyle.solid,
                      color: Colors.black,
                      spreadRadius: 20,
                      blurRadius: 20,
                    )
                  ],
                );
              })
            : null,
        autoFocus: autoFocus,
        growOnFocus: growOnFocus,
        description: description,
        size: size,
        tileColor: color,
        background: images.isNotEmpty ? XboxImageStacker(images: images) : null,
        onTap: onTap,
        title: title,
        dashboardWallpaper: dashboardWallpaper,
        menuItems: menuItems,
      );

  factory XboxTile.iconGradient({required IconData icon, required String title, required Size size, required Gradient gradient, double growOnFocus = 0, Color? color, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false, ImageProvider? dashboardWallpaper}) => XboxTile(
        icon: LayoutBuilder(builder: (context, constraints) {
          return Icon(
            icon,
            color: Colors.white,
            size: constraints.maxHeight - constraints.maxHeight * .6,
            shadows: const [
              BoxShadow(
                blurStyle: BlurStyle.solid,
                color: Colors.black,
                spreadRadius: 20,
                blurRadius: 35,
              )
            ],
          );
        }),
        autoFocus: autoFocus,
        title: title,
        size: size,
        tileColor: color,
        onTap: onTap,
        menuItems: menuItems,
        dashboardWallpaper: dashboardWallpaper,
        growOnFocus: growOnFocus,
        background: Container(decoration: BoxDecoration(gradient: gradient)),
      );

  factory XboxTile.game({required String title, required Size size, required ImageProvider? image, Color? color, double growOnFocus = 0, void Function()? onTap, XboxMenuEntries? menuItems, bool autoFocus = false, ImageProvider? dashboardWallpaper, String upperText = '', IconData? bottomLeftIcon, IconData? bottomRightIcon, bool fixedFocus = false}) => XboxTile(
        autoFocus: autoFocus,
        fixedFocus: fixedFocus,
        background: (image != null ? Image(image: image, fit: BoxFit.cover, alignment: Alignment.topCenter) : null),
        title: title,
        size: size,
        tileColor: color,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
        upperText: upperText,
        dashboardWallpaper: dashboardWallpaper,
        bottomLeftIcon: bottomLeftIcon != null
            ? Icon(
                bottomLeftIcon,
                size: size.height * .15,
                color: Xbox.getReadableColor(color),
              )
            : null,
        bottomRightIcon: bottomRightIcon != null
            ? Icon(
                bottomRightIcon,
                size: size.height * .15,
                color: Colors.white,
              )
            : null,
      );

  double getHeight(bool hasFocus) => growOnFocus > 0 && hasFocus ? size.height + (size.height * growOnFocus) : size.height;

  double getWidth(bool hasFocus) => growOnFocus > 0 && hasFocus ? size.width + (size.width * growOnFocus) : size.width;
}

class _XboxTileState extends State<XboxTile> {
  bool hasFocus = false;

  FocusNode node = FocusNode();

  void _onFocus(bool value) {
    setState(() {
      Xbox.tileWallpaperNotifier.value = widget.dashboardWallpaper;
      hasFocus = value;
    });
  }

  _showMenu() async {
    node.requestFocus();
    debugPrint("showing menu");
    if (widget.menuItems != null && widget.menuItems!.isNotEmpty) {
      await XboxDialog.menu(context, title: [widget.title, widget.description].firstWhere((element) => element.trim().isNotEmpty), menuEntries: widget.menuItems!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isButton = widget.upperText.trim().isEmpty && widget.description.trim().isNotEmpty && widget.title.isEmpty && widget.background == null;
    final bool showTitleBox = !isButton && (hasFocus || widget.fixedFocus) && widget.title.trim().isNotEmpty && widget.description.trim().isEmpty;
    final bool isBanner = widget.background != null && widget.description.trim().isNotEmpty && !showTitleBox;
    return KeyboardListener(
      focusNode: node,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.gameButtonStart || event.logicalKey == LogicalKeyboardKey.gameButtonX || event.logicalKey == LogicalKeyboardKey.contextMenu) {
            _showMenu();
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          node.requestFocus();
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
              decoration: hasFocus ? Xbox.tileInFocus(context) : null,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Xbox.TileRadius),
                    child: GridTile(
                      header: widget.upperText.trim().isNotEmpty ? _upperTextBuilder() : null,
                      footer: showTitleBox ? _titleBoxBuilder() : _lowerIconsBuilder(),
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          _backgroundBuilder(),
                          if (isBanner) _bannerBuilder() else if (isButton) _buttonBuilder() else if (widget.icon != null) _iconBuilder(),
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

  Widget _iconBuilder() {
    return GridTile(child: SizedBox.expand(child: Center(child: widget.icon)));
  }

  Widget _upperTextBuilder() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(Xbox.TileRadius), topRight: Radius.circular(Xbox.TileRadius)),
      child: Container(
        alignment: Alignment.center,
        color: Colors.black.withOpacity(.8),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  widget.upperText,
                  textAlign: TextAlign.center,
                  style: Xbox.getFont(
                    color: Colors.white,
                    fontSize: 12,
                  ).merge(
                    TextStyle(
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
      ),
    );
  }

  Widget? _titleBoxBuilder() {
    return _SlideUpAnimationWrapper(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Xbox.TileRadius), bottomRight: Radius.circular(Xbox.TileRadius)),
        child: Container(
          color: Colors.black.withOpacity(.8),
          alignment: Alignment.bottomLeft,
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
    );
  }

  Widget _backgroundBuilder() {
    if (widget.background != null) {
      return Container(
        color: widget.tileColor ?? Xbox.accentColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Xbox.TileRadius),
          child: widget.background,
        ),
      );
    } else {
      return Container(color: widget.tileColor ?? Xbox.accentColor);
    }
  }

  Widget _bannerBuilder() {
    return Container(
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: GridTile(
          footer: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: getWidth(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title.trim().isNotEmpty)
                      Text(
                        widget.title,
                        style: Xbox.getFont(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getWidth() * .06),
                      ),
                    if (widget.description.trim().isNotEmpty)
                      Text(
                        widget.description,
                        style: Xbox.getFont(color: Colors.white, fontSize: getWidth() * .06),
                      ),
                  ],
                ),
              ),
            ),
          ),
          child: Center(child: widget.icon)),
    );
  }

  Widget _lowerIconsBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.bottomLeftIcon ?? const SizedBox.shrink(),
        ),
        Container(
          color: widget.bottomRightIcon != null ? Colors.black.withOpacity(0.7) : null,
          padding: const EdgeInsets.all(8.0),
          child: widget.bottomRightIcon ?? const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buttonBuilder() {
    return GridTile(
      footer: Align(
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: getWidth(),
          height: getHeight(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (widget.icon != null)
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: getHeight() * 0.7,
                      child: widget.icon,
                    ),
                  ),
                if (widget.description.trim().isNotEmpty)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: Xbox.getFont(
                        color: Xbox.getReadableColor(widget.tileColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      child: const SizedBox.shrink(),
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
