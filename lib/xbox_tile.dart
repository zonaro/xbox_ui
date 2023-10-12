// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:rbox_launcher/util/global.dart';
import 'package:string_extensions/string_extensions.dart';

import 'xbox_colors.dart';

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
  final String? title;

  /// A description for the tile. This is optional and can be null.
  final String? description;

  /// An icon to display on the tile. This is optional and can be null.
  final Widget? icon;

  /// The width of the tile.
  final double width;

  /// The height of the tile.
  final double height;

  final double growOnFocus;

  final bool autoFocus;

  final void Function()? onTap;

  final Map<Widget, void Function()?>? menuItems;

  const XboxTile({super.key, this.background, this.title, this.tileColor, this.growOnFocus = 0, this.icon, required this.width, this.description, this.onTap, required this.height, this.menuItems, required this.autoFocus});

  @override
  State<XboxTile> createState() => _XboxTileState();

  factory XboxTile.icon({required IconData icon, required String title, required double width, required double height, required double iconSize, double growOnFocus = 0, Color? color, void Function()? onTap, Map<Widget, void Function()?>? menuItems, bool autoFocus = false}) => XboxTile(
        icon: Icon(icon, color: Colors.white, size: iconSize),
        autoFocus: autoFocus,
        title: title,
        width: width,
        height: height,
        tileColor: color ?? XboxColors.currentAccentColor,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
      );

  factory XboxTile.flatColor({required Color backgroundColor, required String title, required double width, required double height, double growOnFocus = 0, Color? color, void Function()? onTap, Map<Widget, void Function()?>? menuItems, bool autoFocus = false}) => XboxTile(
        background: Container(color: backgroundColor),
        onTap: onTap,
        autoFocus: autoFocus,
        menuItems: menuItems,
        title: title,
        width: width,
        height: height,
        growOnFocus: growOnFocus,
        tileColor: color ?? XboxColors.currentAccentColor,
      );

  factory XboxTile.iconBanner({required IconData icon, required String description, required double width, required double height, required double iconSize, double growOnFocus = 0, Color? color, Widget? image, void Function()? onTap, Map<Widget, void Function()?>? menuItems, bool autoFocus = false}) => XboxTile(
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
        tileColor: color ?? XboxColors.currentAccentColor,
        background: image,
        onTap: onTap,
        menuItems: menuItems,
      );

  factory XboxTile.iconGradient({required IconData icon, required String title, required double width, required double height, required double iconSize, required Gradient gradient, double growOnFocus = 0, Color? color, void Function()? onTap, Map<Widget, void Function()?>? menuItems, bool autoFocus = false}) => XboxTile(
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
        tileColor: color ?? XboxColors.currentAccentColor,
        onTap: onTap,
        menuItems: menuItems,
        growOnFocus: growOnFocus,
        background: Container(decoration: BoxDecoration(gradient: gradient)),
      );

  factory XboxTile.banner({required String description, required double width, required double height, required Widget image, Color? color, double growOnFocus = 0, void Function()? onTap, Map<Widget, void Function()?>? menuItems, bool autoFocus = false}) => XboxTile(
        autoFocus: autoFocus,
        background: image,
        description: description,
        width: width,
        height: height,
        tileColor: color ?? XboxColors.currentAccentColor,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
      );

  factory XboxTile.game({required String title, required double width, required double height, required Widget image, Color? color, double growOnFocus = 0, void Function()? onTap, Map<Widget, void Function()?>? menuItems, bool autoFocus = false}) => XboxTile(
        autoFocus: autoFocus,
        background: image,
        title: title,
        width: width,
        height: height,
        tileColor: color ?? XboxColors.currentAccentColor,
        onTap: onTap,
        growOnFocus: growOnFocus,
        menuItems: menuItems,
      );
}

class _XboxTileState extends State<XboxTile> {
  bool hasFocus = false;

  void onFocus(bool value) {
    setState(() {
      hasFocus = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 7;

    final bool hideDescription = widget.description.isBlank || (widget.title.isNotBlank && !hasFocus);

    final bool hideGameTitle = (widget.title.isBlank || !hasFocus);

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: () async {
        if (widget.menuItems != null && widget.menuItems!.isNotEmpty) await showOptionsDialog(context, widget.title ?? "", widget.menuItems!);
      },
      child: FocusableActionDetector(
        descendantsAreFocusable: false,
        descendantsAreTraversable: false,
        onShowHoverHighlight: onFocus,
        onShowFocusHighlight: onFocus,
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
                        color: XboxColors.currentAccentColor,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(radius),
                  )
                : null,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: GridTile(
                    footer: hideGameTitle
                        ? null
                        : Animate(
                            effects: const [SlideEffect(begin: Offset(0, 1), duration: Duration(milliseconds: 50))],
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius)),
                              child: Container(
                                color: Colors.black.withOpacity(.8),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      widget.title ?? "",
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
                        Container(color: widget.tileColor ?? XboxColors.currentAccentColor),
                        if (widget.background != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radius),
                            child: widget.background,
                          ),
                        Container(
                          decoration: !hideDescription ? const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.transparent, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter)) : null,
                          child: GridTile(
                              footer: !hideDescription
                                  ? Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        widget.description ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
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
    );
  }

  double getHeight() => widget.growOnFocus > 0 && hasFocus ? widget.height + (widget.height * widget.growOnFocus) : widget.height;

  double getWidth() => widget.growOnFocus > 0 && hasFocus ? widget.width + (widget.width * widget.growOnFocus) : widget.width;
}
