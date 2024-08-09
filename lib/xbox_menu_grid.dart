import 'package:flutter/material.dart';

class XboxMenuGrid extends StatefulWidget {
  const XboxMenuGrid({super.key, required this.views, this.startView});

  final Map<String, List<Widget>> views;

  final String? startView;

  @override
  State<XboxMenuGrid> createState() => _XboxMenuGridState();
}

class _XboxMenuGridState extends State<XboxMenuGrid> {
  String? currentKey;

  @override
  void initState() {
    if (widget.startView != null) {
      currentKey = widget.startView;
    }

    super.initState();
  }

  List<String> get menus => widget.views.keys.toList();

  @override
  Widget build(BuildContext context) {
    if (widget.views.isNotEmpty) {
      if (!menus.contains(currentKey)) {
        currentKey = null;
      }

      currentKey = currentKey ?? widget.views.keys.first;

      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
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
              color: Theme.of(context).colorScheme.surface,
              child: GridView.count(crossAxisCount: 5, children: widget.views[currentKey] ?? []),
            ),
          ),
        ],
      );
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Center(child: Icon(Icons.error)),
    );
  }
}
