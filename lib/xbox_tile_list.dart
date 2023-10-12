// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_tile.dart';

class XboxTileList extends StatelessWidget {
  final String? title;

  final List<XboxTile> tiles;

  const XboxTileList({Key? key, this.title, required this.tiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title?.trim() != "")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.05),
              ),
            ),
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
    var l =  tiles.map((e) => e.getHeight(true)).toList()..sort();
    return l.last;
  }
}
