// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_tile_list.dart';

class XboxTileView extends StatelessWidget {
  
  final List<XboxTileList> items;

  const XboxTileView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: items,
        ),
      ),
    );
  }
}
