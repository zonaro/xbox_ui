import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
 
import 'xbox_colors.dart';

class XboxDashboard extends StatefulWidget {
  const XboxDashboard({super.key, required this.child, required this.topBarItens, this.wallpaper, this.avatar, this.menu, required this.username, required this.userdetail});

  final List<Widget> topBarItens;

  final Widget child;
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
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Stack(
      fit: StackFit.expand,
      children: [
        if (widget.wallpaper != null) SizedBox(width: MediaQuery.of(context).size.width, child: widget.wallpaper),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.7),
          drawer: widget.menu,
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            leadingWidth: MediaQuery.of(context).size.width * 0.3,
            automaticallyImplyLeading: true,
            leading: GestureDetector(
              onTap: () => scaffoldKey.currentState?.openDrawer(),
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
                        child: widget.avatar ?? const Icon(Icons.person),
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
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.topBarItens,
            ),
          ),
          body: widget.child,
        ),
      ],
    );
  }
}
