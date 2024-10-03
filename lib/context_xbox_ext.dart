// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_achievement.dart';
import 'package:xbox_ui/xbox_dialog.dart';

extension ContextXboxExt on BuildContext {
  void showXboxNotification({
    required String title,
    String? subTitle,
    Widget? icon,
    Color? color,
    Duration duration = const Duration(seconds: 4),
    AlignmentGeometry alignment = Alignment.bottomCenter,
    BorderRadiusGeometry? borderRadius,
    BorderRadiusGeometry? iconBorderRadius,
    bool isCircle = true,
    Widget? content,
    Function(AchievementState)? listener,
    AnimationTypeAchievement typeAnimationContent = AnimationTypeAchievement.fadeSlideToUp,
    GestureTapCallback? onTap,
    VoidCallback? finish,
  }) {
    XboxNotification(
      title: title,
      subTitle: subTitle,
      icon: icon,
      color: color,
      duration: duration,
      alignment: alignment,
      borderRadius: borderRadius,
      iconBorderRadius: iconBorderRadius,
      isCircle: isCircle,
      content: content,
      listener: listener,
      typeAnimationContent: typeAnimationContent,
      onTap: onTap,
      finish: finish,
    ).show(this);
  }

  Future<String?> showXboxPrompt({
    String? title,
    String? content,
    String? textOK,
    String? textCancel,
    String? value,
    Function(String?)? onOK,
    Function(String?)? onCancel,
  }) =>
      XboxDialog.prompt(
        this,
        title: title,
        content: content,
        textOK: textOK,
        textCancel: textCancel,
        value: value,
      );

  Future<void> showXboxDialog({
    required String text,
    String? title,
    Widget? icon,
    String? textOK,
  }) =>
      XboxDialog.alert(
        this,
        text: text,
        title: title,
        icon: icon,
        textOK: textOK,
      );

  Future<bool?> showXboxConfirm({
    String? content,
    String? title,
    String? textOK,
    String? textCancel,
  }) =>
      XboxDialog.confirm(
        this,
        content: content,
        title: title,
        textOK: textOK,
        textCancel: textCancel,
      );
}
