import 'package:flutter/material.dart';

class XboxPopupMenu extends StatelessWidget {
  const XboxPopupMenu({
    super.key,
    required this.title,
    required this.menuItems,
  });

  final String title;
  final Map<String, void Function()?> menuItems;

  @override
  Widget build(BuildContext context) => SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(title),
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

  static Future<void> showMenu(BuildContext context, {required String title, required Map<String, void Function()?> menuItems}) => XboxPopupMenu(title: title, menuItems: menuItems).show(context);
}
