import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_ui.dart';

class XboxPopupMenu extends StatelessWidget {
  const XboxPopupMenu({
    super.key,
    this.title = '',
    required this.menuItems,
  });

  final String title;
  final XboxMenuEntries menuItems;

  @override
  Widget build(BuildContext context) => SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(xboxTileRadius)),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: title.trim().isNotEmpty ? Text(title) : null,
      children: menuItems.entries
          .map(
            (e) => SimpleDialogOption(
              onPressed: e.value,
              child: Text(e.key),
            ),
          )
          .toList());

  Future<void> show(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return this;
        },
      );

  static Future<void> showMenu(BuildContext context, {required String title, required XboxMenuEntries menuItems}) => XboxPopupMenu(title: title, menuItems: menuItems).show(context);
}
