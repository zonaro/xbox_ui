// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox.dart';
import 'package:xbox_ui/xbox_dialog.dart';

class XboxLoadingBar extends StatefulWidget {
  final String title;

  XboxLoadingBar({
    super.key,
    required this.title,
    String? description,
  }) {
    _description.value = description;
  }

  bool setValue(double? value) {
    _valueBar.value = value;
    if ((_valueBar.value ?? 0) > 1.0) {
      _valueBar.value = 1;
    }
    return _valueBar.value == 1;
  }

  bool increaseValue(double value) {
    _valueBar.value = _valueBar.value ?? 0;
    return setValue(_valueBar.value! + value);
  }

  void setDescription(String? value) {
    _description.value = value;
  }

  final ValueNotifier<double?> _valueBar = ValueNotifier(null);
  final ValueNotifier<String?> _description = ValueNotifier(null);

  @override
  State<XboxLoadingBar> createState() => _XboxLoadingBarState();

  XboxLoadingBar show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => this,
    );
    return this;
  }
}

class _XboxLoadingBarState extends State<XboxLoadingBar> {
  @override
  void initState() {
    widget._valueBar.addListener(() {
      setState(() {});
    });
    widget._description.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    try {
      widget._description.dispose();
      widget._valueBar.dispose();
    } catch (e) {
      //
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => XboxDialog(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          if (widget._description.value != null) const SizedBox(height: 10),
          if (widget._description.value != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget._description.value!,
                style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            color: Xbox.accentColor,
            value: (widget._valueBar.value),
          ),
          if (widget._valueBar.value != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("${(widget._valueBar.value! * 100).toStringAsFixed(1)}%"),
              ),
            )
        ],
      );
}
