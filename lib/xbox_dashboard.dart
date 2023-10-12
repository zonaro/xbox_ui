import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innerlibs/future_awaiter.dart';
import 'package:rbox_launcher/components/search.dart';

import 'package:rbox_launcher/util/global.dart';
import 'package:rbox_launcher/main.dart';

import 'xbox_colors.dart';

class XboxDashboard extends StatefulWidget {
  const XboxDashboard({super.key, required this.body});
  final Widget body;

  @override
  State<XboxDashboard> createState() => _XboxDashboardState();
}

class _XboxDashboardState extends State<XboxDashboard> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) => FutureAwaiter(
        future: romGroups(context),
        loadingWidget: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: mainColor,
          child: const Center(child: CircularProgressIndicator()),
        ),
        doneWidget: (items) => Stack(
          fit: StackFit.expand,
          children: [
            if ([".jpg", ".jpeg", ".png", ".gif"].any((e) => wallpaper.endsWith(e)))
              SizedBox(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: wallpaper.startsWith("assets/")
                    ? Image.asset(
                        wallpaper,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(wallpaper),
                        fit: BoxFit.cover,
                      ),
              ),
            Scaffold(
                key: _key,
                backgroundColor: XboxColors.GrayBackground.withOpacity(.7),
                drawer: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Drawer(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: XboxColors.GrayBackground,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: mainColor,
                          ),
                          child: Text(devInf.manufacturer),
                        ),
                        ListTile(
                          title: const Text('Home'),
                          onTap: () {
                            backHome(context);
                          },
                        ),
                        ListTile(
                            title: const Text('Accent Color'),
                            onTap: () async {
                              await colorDialog(context);
                              setState(() {});
                            }),
                        ListTile(
                          title: const Text('Wallpaper'),
                          onTap: () async {
                            await wallpaperDialog(context).then((value) => setState(() {}));
                          },
                        ),
                        ListTile(
                          title: const Text('Achievements'),
                          onTap: () async {
                            showAchievementView(context, "First Achievement", "this is the first of all");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                extendBody: true,
                appBar: AppBar(
                  centerTitle: true,
                  surfaceTintColor: Colors.transparent,
                  leadingWidth: MediaQuery.of(context).size.width * 0.3,
                  leading: GestureDetector(
                    onTap: () => _key.currentState?.openDrawer(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Wrap(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            backgroundColor: mainColor,
                            //child: Text("${initials.first.first()}${initials.skip(1).lastOrNull.ifBlank("")?.last()}"),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "https://api.dicebear.com/7.x/pixel-art/png?seed=$username",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                username,
                                maxLines: 1,
                                minFontSize: 4,
                                maxFontSize: 20,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              AutoSizeText(
                                devInf.model,
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(FluentIcons.library_16_regular),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(FluentIcons.store_microsoft_20_regular),
                            onPressed: () async {
                              await launchOrSelect(context, "Store", ["com.android.vending", "com.aurora.store", "org.fdroid.fdroid"]);
                            },
                          ),
                          IconButton(
                            icon: const Icon(FluentIcons.xbox_console_20_regular),
                            onPressed: () async {
                              await launchOrSelect(context, "Cloud Gaming", ["com.nvidia.geforcenow", "com.microsoft.xboxone.smartglass", "com.playstation.remoteplay", "psplay.grill.com", "com.gamepass", "com.limelight", "tv.parsec.client", "com.valvesoftware.steamlink"]);
                            },
                          ),
                          IconButton(
                            icon: const Icon(FluentIcons.search_12_regular),
                            onPressed: () async {
                              await showSearch(context: context, delegate: CustomSearchDelegate());
                            },
                          ),
                          IconButton(
                            icon: const Icon(FluentIcons.settings_16_regular),
                            onPressed: () {
                              DeviceApps.openApp("com.android.settings");
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      )
                    ],
                  ),
                ),
                body: widget.body),
          ],
        ),
      );
}
