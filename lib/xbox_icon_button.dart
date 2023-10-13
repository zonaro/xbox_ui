import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_colors.dart';

class XboxIconButton extends StatefulWidget {
  const XboxIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.size = 30,
  });

  final void Function()? onPressed;

  final Widget icon;
  final Widget? selectedIcon;
  final double size;

  @override
  State<XboxIconButton> createState() => _XboxIconButtonState();
}

class _XboxIconButtonState extends State<XboxIconButton> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: hasFocus ? XboxColors.currentAccentColor : Colors.transparent, width: 4.0),
                color: Theme.of(context).colorScheme.background.withOpacity(.7),
                shape: BoxShape.circle,
              ),
              child: InkWell(
                enableFeedback: false,
                onFocusChange: (v) {
                  setState(() {
                    hasFocus = v;
                  });
                },
                //This keeps the splash effect within the circle
                borderRadius: BorderRadius.circular(double.infinity), //Something large to ensure a circle
                onTap: widget.onPressed,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: widget.size * 0.7,
                    height: widget.size * 0.7,
                    child: hasFocus ? (widget.selectedIcon ?? widget.icon) : widget.icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
