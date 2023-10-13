import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xbox_ui/xbox_utils.dart';

import 'xbox_colors.dart';

class XboxDashboard extends StatefulWidget {
  const XboxDashboard({super.key, required this.body, required this.topBarItens, this.wallpaper, this.avatar, this.menu, required this.username, required this.userdetail});

  final List<Widget> topBarItens;

  final Widget body;
  final Widget? wallpaper;
  final Widget? avatar;
  final Widget? menu;
  final String username;
  final String userdetail;

  @override
  State<XboxDashboard> createState() => _XboxDashboardState();
}

class _XboxDashboardState extends State<XboxDashboard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (widget.wallpaper != null) SizedBox(width: MediaQuery.of(context).size.width, child: widget.wallpaper),
        Scaffold(
          key: Xbox.globalkey,
          backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.7),
          drawer: widget.menu,
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            leadingWidth: MediaQuery.of(context).size.width * 0.3,
            leading: GestureDetector(
              onTap: () => Xbox,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Wrap(
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      backgroundColor: XboxColors.currentAccentColor,
                      //child: Text("${initials.first.first()}${initials.skip(1).lastOrNull.ifBlank("")?.last()}"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.avatar,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          widget.username,
                          maxLines: 1,
                          minFontSize: 4,
                          maxFontSize: 20,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          widget.userdetail,
                          maxLines: 1,
                          minFontSize: 2,
                          maxFontSize: 15,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            toolbarHeight: 85,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.topBarItens,
            ),
          ),
          body: widget.body,
        ),
      ],
    );
  }
}
