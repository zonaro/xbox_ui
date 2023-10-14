import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox.dart';

class XboxMenu extends StatelessWidget {
  final List<Widget> items;

  const XboxMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Drawer(
        shape: Xbox.defaultBorderShape,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: ListView(shrinkWrap: true, children: items),
      ),
    );
  }
}
