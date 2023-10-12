import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innerlibs/future_awaiter.dart';
import 'package:innerlibs/string_extensions.dart';
import 'package:rbox_launcher/components/pallete.dart';
import 'package:rbox_launcher/components/xbox_colors.dart';
import 'package:rbox_launcher/components/xbox_tile.dart';
import 'package:rbox_launcher/util/global.dart';
import 'package:rbox_launcher/main.dart';

class XboxMenuGrid extends StatelessWidget {
  const XboxMenuGrid({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XboxColors.GrayBackground,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: XboxColors.GrayBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: "Apps".asText,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: XboxColors.GrayBackground,
              child: FutureAwaiter(
                future: () async {
                  var apps = await DeviceApps.getInstalledApplications(
                    includeSystemApps: true,
                    onlyAppsWithLaunchIntent: true,
                    includeAppIcons: true,
                  );

                  apps.sort((a, b) => a.appName.compareTo(b.appName)); // Sort in alphabetical order

                  return apps
                      .map(
                        (app) => FutureAwaiter(
                          future: ImageColor.getAccentColorFromBytes(app is ApplicationWithIcon ? app.icon : Uint8List(0)),
                          doneWidget: (color) => XboxTile.game(
                            color: color ?? mainColor,
                            title: app.appName,
                            width: 100,
                            height: 100,
                            onTap: () {
                              enterSound();
                              app.openApp();
                            },
                            image: Padding(
                              padding: const EdgeInsets.all(15),
                              child: app is ApplicationWithIcon ? Image.memory(app.icon) : const Placeholder(),
                            ),
                          ),
                        ),
                      )
                      .toList();
                }(),
                doneWidget: (items) => GridView.count(crossAxisCount: 5, children: items),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
