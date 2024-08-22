// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox.dart';

enum AchievementState {
  opening,
  open,
  closing,
  closed,
}

enum AnimationTypeAchievement {
  fadeSlideToUp,
  fadeSlideToLeft,
  fade,
}

class XboxNotification extends StatefulWidget {
  final AlignmentGeometry alignment;
  final Duration duration;
  final GestureTapCallback? onTap;
  final Function(AchievementState)? listener;
  final Widget? icon;
  final AnimationTypeAchievement typeAnimationContent;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? iconBorderRadius;
  final Color? color;
  final bool isCircle;
  final String? title;
  final String? subTitle;
  final double elevation;
  final OverlayState? overlay;
  final Widget? content;

  XboxNotification({
    super.key,
    this.isCircle = true,
    this.elevation = 3,
    this.onTap,
    this.listener,
    this.overlay,
    this.icon,
    this.typeAnimationContent = AnimationTypeAchievement.fadeSlideToUp,
    this.borderRadius,
    this.iconBorderRadius,
    this.color,
    this.alignment = Alignment.bottomCenter,
    this.duration = const Duration(seconds: 4),
    this.title,
    this.subTitle,
    this.content,
    this.finish,
  });

  final VoidCallback? finish;
  OverlayEntry? _overlayEntry;

  OverlayEntry _buildOverlay() {
    return OverlayEntry(builder: (context) {
      return this;
    });
  }

  void show(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = _buildOverlay();
      (overlay ?? Overlay.of(context)).insert(_overlayEntry!);
    }
  }

  @override
  createState() => _XboxNotificationState();
}

class _XboxNotificationState extends State<XboxNotification> with TickerProviderStateMixin {
  static const heightCard = 60.0;
  static const marginCard = 20.0;

  late AnimationController _controllerScale;
  late CurvedAnimation _curvedAnimationScale;

  late AnimationController _controllerSize;
  late CurvedAnimation _curvedAnimationSize;

  late AnimationController _controllerTitle;
  late Animation<Offset> _titleSlideUp;

  late AnimationController _controllerSubTitle;
  late Animation<Offset> _subTitleSlideUp;

  @override
  void initState() {
    _controllerScale = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _curvedAnimationScale = CurvedAnimation(parent: _controllerScale, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerSize.forward();
        }
        if (status == AnimationStatus.dismissed) {
          _notifyListener(AchievementState.closed);
          widget.finish?.call();
        }
      });

    _controllerSize = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerTitle.forward();
        }
        if (status == AnimationStatus.dismissed) {
          _controllerScale.reverse();
        }
      });
    _curvedAnimationSize = CurvedAnimation(
      parent: _controllerSize,
      curve: Curves.ease,
    );

    _controllerTitle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerSubTitle.forward();
        }
        if (status == AnimationStatus.dismissed) {
          _controllerSize.reverse();
        }
      });

    _titleSlideUp = _buildAnimatedContent(_controllerTitle);

    _controllerSubTitle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _notifyListener(AchievementState.open);
          _startTime();
        }
        if (status == AnimationStatus.dismissed) {
          _controllerTitle.reverse();
        }
      });

    _subTitleSlideUp = _buildAnimatedContent(_controllerSubTitle);
    super.initState();
    show();
  }

  void show() {
    _notifyListener(AchievementState.opening);
    _controllerScale.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(minHeight: heightCard),
        margin: const EdgeInsets.all(marginCard),
        child: ScaleTransition(
          scale: _curvedAnimationScale,
          child: _buildAchievement(),
        ),
      ),
    );
  }

  Widget _buildAchievement() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Xbox.TileRadius),
      child: Align(
        alignment: widget.alignment,
        child: Material(
          type: MaterialType.transparency,
          elevation: widget.elevation,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color ?? Xbox.accentColor,
              borderRadius: _buildBorderCard(),
            ),
            child: Ink(
              child: InkWell(
                onTap: widget.onTap,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildIcon(),
                      _buildContent(),
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

  Widget _buildIcon() {
    return Container(
      color: Xbox.SlateGray.withOpacity(.9),
      width: heightCard,
      alignment: Alignment.center,
      child: widget.icon ??
          Icon(
            Icons.diamond,
            color: widget.color ?? Xbox._accentColorNotifier.value,
          ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      child: AnimatedBuilder(
        animation: _curvedAnimationSize,
        builder: (context, child) {
          return Align(
            widthFactor: _curvedAnimationSize.value,
            heightFactor: 1,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: _buildPaddingContent(),
              child: widget.content != null
                  ? _buildCustomContent(widget.content!)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (widget.title != null) _buildTitle(widget.title!),
                        if (widget.subTitle != null) ...[
                          const SizedBox(height: 2),
                          _buildSubTitle(widget.subTitle!),
                        ],
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomContent(Widget content) {
    return AnimatedBuilder(
      animation: _controllerTitle,
      builder: (_, child) {
        return FadeTransition(
          opacity: _controllerTitle,
          child: child,
        );
      },
      child: content,
    );
  }

  Widget _buildTitle(String title) {
    return AnimatedBuilder(
      animation: _controllerTitle,
      builder: (_, child) {
        return SlideTransition(
          position: _titleSlideUp,
          child: FadeTransition(
            opacity: _controllerTitle,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          title,
          softWrap: true,
          style: Xbox.getFont(color: Xbox.getReadableColor(widget.color ?? Xbox._accentColorNotifier.value), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSubTitle(String subTitle) {
    return AnimatedBuilder(
        animation: _controllerSubTitle,
        builder: (_, child) {
          return SlideTransition(
            position: _subTitleSlideUp,
            child: FadeTransition(
              opacity: _controllerSubTitle,
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            subTitle,
            style: TextStyle(color: Xbox.getReadableColor(widget.color ?? Xbox._accentColorNotifier.value)),
          ),
        ));
  }

  BorderRadiusGeometry _buildBorderCard() {
    return widget.isCircle ? const BorderRadius.all(Radius.circular(1000)) : const BorderRadius.all(Radius.circular(Xbox.TileRadius));
  }

  EdgeInsets _buildPaddingContent() => const EdgeInsets.fromLTRB(0, 15, 15, 15);

  Animation<Offset> _buildAnimatedContent(AnimationController controller) {
    double dx = 0.0;
    double dy = 0.0;
    switch (widget.typeAnimationContent) {
      case AnimationTypeAchievement.fadeSlideToUp:
        {
          dy = 2.0;
        }
        break;
      case AnimationTypeAchievement.fadeSlideToLeft:
        {
          dx = 2.0;
        }
        break;
      case AnimationTypeAchievement.fade:
        {}
        break;
    }
    return Tween(begin: Offset(dx, dy), end: const Offset(0.0, 0.0)).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
  }

  void _notifyListener(AchievementState state) {
    widget.listener?.call(state);
  }

  void _startTime() {
    Future.delayed(widget.duration, () {
      _notifyListener(AchievementState.closing);
      _controllerSubTitle.reverse();
    });
  }

  @override
  void dispose() {
    _controllerScale.dispose();
    _controllerSize.dispose();
    _controllerTitle.dispose();
    _controllerSubTitle.dispose();
    super.dispose();
  }
}
