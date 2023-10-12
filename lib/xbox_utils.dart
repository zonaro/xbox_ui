import 'package:flutter/material.dart';

class XboxPopupMenu extends StatelessWidget {
  const XboxPopupMenu({
    super.key,
    required this.title,
    required this.onPress,
  });

  final String title;
  final Map<Widget, void Function()?> onPress;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(title),
        children: onPress.entries
            .map(
              (e) => SimpleDialogOption(
                onPressed: e.value,
                child: e.key,
              ),
            )
            .toList());
  }

  Future<void> show(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );

  static Future<void> showMenu(BuildContext context, String title, Map<Widget, void Function()?> onPress) => XboxPopupMenu(title: title, onPress: onPress).show(context);
}
