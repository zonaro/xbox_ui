import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox.dart';

class XboxMenu extends StatelessWidget {
  final List<Widget> items;

  const XboxMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Drawer(
        shape: Xbox.defaultShape,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: ListView(shrinkWrap: true, children: items),
      ),
    );
  }
}
