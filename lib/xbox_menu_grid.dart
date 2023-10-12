import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
 

class XboxMenuGrid extends StatefulWidget {
  const XboxMenuGrid({super.key, required this.views});
  final Map<String, List<Widget>> views;

  @override
  State<XboxMenuGrid> createState() => _XboxMenuGridState();
}

class _XboxMenuGridState extends State<XboxMenuGrid> {
  String? currentKey;

  @override
  Widget build(BuildContext context) {
    currentKey ??= widget.views.keys.firstOrNull;

    if (widget.views.isNotEmpty) {
      if (!widget.views.keys.contains(currentKey)) {
        currentKey ??= widget.views.keys.first;
      }

      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var x in widget.views.keys)
                    ListTile(
                      title: Text(x),
                    )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: GridView.count(crossAxisCount: 5, children: widget.views[currentKey] ?? []),
            ),
          ),
        ],
      );
    }
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Center(child: Icon(FluentIcons.error_circle_24_filled)),
    );
  }
}
