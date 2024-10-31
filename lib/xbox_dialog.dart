// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_ui.dart';

import 'xbox_loading_bar.dart';

class XboxDialog extends StatelessWidget {
  final List<Widget> children;

  const XboxDialog({super.key, required this.children});

  @override
  Widget build(BuildContext context) => Dialog(
        shape: Xbox.defaultBorderShape,
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Xbox.tileRadius),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 2 / 3,
            child: LayoutBuilder(builder: (context, cs) {
              return Container(
                width: cs.maxWidth,
                height: cs.maxHeight,
                padding: const EdgeInsets.all(15),
                color: Theme.of(context).colorScheme.surface,
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              );
            }),
          ),
        ),
      );

  static Future<void> alert(
    BuildContext context, {
    required String text,
    String? title,
    Widget? icon,
    String? textOK,
  }) async {
    showDialog(
      context: context,
      builder: (_) => XboxDialog(
        children: [
          if (icon != null) icon,
          const SizedBox(height: 20),
          Text(text),
          XboxTile.button(
            title: (textOK ?? MaterialLocalizations.of(context).okButtonLabel),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  static Future<bool> confirm(
    BuildContext context, {
    String? title,
    String? content,
    String? textOK,
    String? textCancel,
  }) async {
    final bool? isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) => XboxDialog(
        children: [
          Text(
            content ?? 'Are you sure to continue?',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                XboxTile.button(
                  title: textCancel ?? MaterialLocalizations.of(context).cancelButtonLabel,
                  onTap: () => Navigator.pop(context, false),
                ),
                XboxTile.button(
                  title: textOK ?? MaterialLocalizations.of(context).okButtonLabel,
                  onTap: () => Navigator.pop(context, true),
                ),
              ],
            ),
          )
        ],
      ),
    );

    return isConfirm ?? false;
  }

  static XboxLoadingBar loadingBar(BuildContext context, {required String title, String description = '', double? value}) => XboxLoadingBar(
        title: title,
        description: description,
      ).show(context);

  static Future<void> menu(BuildContext context, {required String title, required XboxMenuEntries menuEntries}) => showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(shape: Xbox.defaultBorderShape, backgroundColor: Theme.of(context).colorScheme.surface, titleTextStyle: Xbox.getFont(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 20), title: title.trim().isNotEmpty ? Text(title) : null, children: menuEntries.entries.map((e) => XboxMenuItem(title: e.key, onTap: e.value)).toList()),
      );

  static void notification(BuildContext context, {required String title, String? subtitle, IconData? icon, AlignmentGeometry alignment = Alignment.bottomCenter}) {
    return XboxNotification(
      title: title,
      subTitle: subtitle,
      icon: icon != null ? Icon(icon) : null,
      alignment: alignment,
    ).show(context);
  }

  static Future<String?> prompt(
    BuildContext context, {
    String? title,
    String? content,
    String? textOK,
    String? textCancel,
    String? value,
  }) async {
    final TextEditingController controller = TextEditingController(text: value);
    final bool? isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: Xbox.defaultBorderShape,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          title ?? "",
          style: Xbox.getFont(color: Xbox.getContrastThemeColor(context)),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(content ?? 'Please enter your input:', style: Xbox.getFont(color: Xbox.getContrastThemeColor(context))),
              TextField(
                controller: controller,
                style: Xbox.getFont(color: Xbox.getContrastThemeColor(context)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          XboxTile.button(
            title: textCancel ?? MaterialLocalizations.of(context).cancelButtonLabel,
            onTap: () => Navigator.pop(context, false),
          ),
          XboxTile.button(
            title: textOK ?? MaterialLocalizations.of(context).okButtonLabel,
            onTap: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    return isConfirm == true ? controller.text : null;
  }
}

class XboxMenuItem extends StatefulWidget {
  final String title;

  final VoidCallback? onTap;
  final bool? hasFocus;
  final IconData? icon;

  const XboxMenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.hasFocus,
    this.icon,
  });

  @override
  State<XboxMenuItem> createState() => _XboxMenuItemState();
}

class _XboxMenuItemState extends State<XboxMenuItem> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: FocusScope(
        child: GestureDetector(
          onTap: widget.onTap,
          child: FocusableActionDetector(
            onFocusChange: (value) => setState(() => hasFocus = value),
            onShowFocusHighlight: (value) => setState(() => hasFocus = value),
            onShowHoverHighlight: (value) => setState(() => hasFocus = value),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: widget.hasFocus ?? hasFocus ? Xbox.tileInFocus(context) : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) Icon(widget.icon),
                      SizedBox(width: widget.icon != null ? 10 : 0),
                      Text(
                        widget.title,
                        style: Xbox.getFont(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
