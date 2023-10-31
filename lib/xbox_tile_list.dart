// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox.dart';
import 'package:xbox_ui/xbox_tile.dart';

class XboxTileList extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;

  final List<XboxTile> tiles;

  const XboxTileList({Key? key, this.title = '', required this.tiles, this.titleWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wid = titleWidget ??
        ((title ?? "").trim().isNotEmpty
            ? Text(
                title ?? "",
                style: Xbox.getFont(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Xbox.getContrastThemeColor(context)
                ),
              )
            : null);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (wid != null) Padding(padding: const EdgeInsets.all(8.0), child: wid),
          SizedBox(
            height: getHeight(),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: tiles,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getHeight() {
    var l = tiles.map((e) => e.getHeight(true)).toList()..sort();
    return l.last;
  }
}
