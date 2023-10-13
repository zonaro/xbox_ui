import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_colors.dart';

class XboxCircleButton extends StatefulWidget {
  const XboxCircleButton({
    super.key,
    this.onPressed,
    required this.child,
    this.selectedChild,
    this.size = 30,
    this.backgroundColor,
  });

  factory XboxCircleButton.icon(double size, IconData icon, {IconData? selectedIcon, void Function()? onPressed}) {
    final iconsize = size - size * .3;
    return XboxCircleButton(
      selectedChild: Icon(selectedIcon ?? icon, size: iconsize),
      onPressed: onPressed,
      child: Icon(icon, size: iconsize),
    );
  }

  final void Function()? onPressed;

  final Widget child;
  final Widget? selectedChild;
  final double size;
  final Color? backgroundColor;

  @override
  State<XboxCircleButton> createState() => _XboxCircleButtonState();
}

class _XboxCircleButtonState extends State<XboxCircleButton> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: widget.size,
    height: widget.size,
    child: Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: hasFocus ? XboxColors.currentAccentColor : Colors.transparent, width: 2.5),
          color: widget.backgroundColor ?? Theme.of(context).colorScheme.background.withOpacity(.5),
          shape: BoxShape.circle,
        ),
        child: InkWell(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,

          enableFeedback: false,
          onFocusChange: (v) {
            setState(() {
              hasFocus = v;
            });
          },
          //This keeps the splash effect within the circle
          borderRadius: BorderRadius.circular(double.infinity), //Something large to ensure a circle
          onTap: widget.onPressed,
          child: Center(child: hasFocus ? (widget.selectedChild ?? widget.child) : widget.child),
        ),
      ),
    ),
  );
}
