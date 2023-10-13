import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_ui.dart';

mixin XboxDialog {
  static RoundedRectangleBorder get defaultShape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(xboxTileRadius));

  static Future<void> menu(BuildContext context, {required String title, required XboxMenuEntries menuEntries}) => showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
            shape: defaultShape,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: title.trim().isNotEmpty ? Text(title) : null,
            children: menuEntries.entries
                .map(
                  (e) => SimpleDialogOption(
                    onPressed: e.value,
                    child: Text(e.key),
                  ),
                )
                .toList()),
      );

  /// The `title` argument is used to title of alert dialog.
  /// The `content` argument is used to content of alert dialog.
  /// The `textOK` argument is used to text for 'OK' Button of alert dialog.
  /// The `textCancel` argument is used to text for 'Cancel' Button of alert dialog.
  ///
  /// Returns a [Future<bool>].
  Future<bool> confirm(
    BuildContext context, {
    String? title,
    String? content,
    String? textOK,
    String? textCancel,
  }) async {
    final bool? isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: defaultShape,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(title ?? ""),
        content: SingleChildScrollView(
          child: Text(content ?? 'Are you sure continue?'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(textCancel ?? MaterialLocalizations.of(context).cancelButtonLabel),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(textOK ?? MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    return isConfirm ?? false;
  }

  Future<void> alert(
    BuildContext context, {
    required String text,
    String? title,
    Widget? icon,
    String? textOK,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: defaultShape,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(title ?? ""),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              if (icon != null) icon,
              const SizedBox(height: 20),
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(textOK ?? MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<String?> prompt(
    BuildContext context, {
    String? title,
    String? content,
    String? textOK,
    String? textCancel,
  }) async {
    final TextEditingController controller = TextEditingController();
    final bool? isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: defaultShape,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(title ?? ""),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(content ?? 'Please enter your input:'),
              TextField(
                controller: controller,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(textCancel ?? MaterialLocalizations.of(context).cancelButtonLabel),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(textOK ?? MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    return isConfirm == true ? controller.text : null;
  }
}
