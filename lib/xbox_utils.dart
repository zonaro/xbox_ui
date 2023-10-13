import 'package:flutter/material.dart';

mixin Xbox {

  static GlobalKey<ScaffoldState> globalkey = GlobalKey(debugLabel: "Xbox global key");

 static showMenu() {
    globalkey.currentState?.openDrawer();
  }
}
