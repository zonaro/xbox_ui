import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_dialog.dart';

class XboxInternalEntry {
  final String title;
  final IconData? icon;

  final Widget Function(BuildContext context) pageBuilder;
  final Widget Function(BuildContext context)? footerBuilder;

  const XboxInternalEntry({
    required this.title,
    required this.pageBuilder,
    this.footerBuilder,
    this.icon,
  });
}

class XboxInternalPage extends StatefulWidget {
  final String title;
  final List<XboxInternalEntry> entries;
  final Widget? footer;

  const XboxInternalPage({super.key, required this.title, required this.entries, this.footer});

  @override
  State<XboxInternalPage> createState() => _XboxInternalPageState();
}

class _XboxInternalPageState extends State<XboxInternalPage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entries[activeIndex].title),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                for (var entry in widget.entries)
                  XboxMenuItem(
                      title: entry.title,
                      icon: entry.icon,
                      hasFocus: widget.entries.indexOf(entry) == activeIndex,
                      onTap: () {
                        setState(() {
                          activeIndex = widget.entries.indexOf(entry);
                        });
                      }),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Builder(builder: widget.entries[activeIndex].pageBuilder),
                if (widget.entries[activeIndex].footerBuilder != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(builder: widget.entries[activeIndex].footerBuilder!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
