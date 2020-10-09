/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/projects/projects_screen.dart';
import 'package:bom_bar_ui/services/bom_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

const platform = null;
// const platform = TargetPlatform.linux;
// const platform = TargetPlatform.macOS;
const darkMode = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final materialTheme = new ThemeData(
    primarySwatch: Colors.purple,
  );
  final materialDarkTheme = new ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
  );
  final cupertinoTheme = new CupertinoThemeData(
    brightness: darkMode ? Brightness.dark : Brightness.light,
    primaryColor: CupertinoDynamicColor.withBrightness(
      color: Colors.purple,
      darkColor: Colors.cyan,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: materialTheme,
      child: Provider(
        create: (_)=>BomService(),
        child: initUI(),
      ),
    );
  }

  PlatformProvider initUI() {
    return PlatformProvider(
        initialPlatform: platform,
        builder: (context) => PlatformApp(
          title: 'BOM-bar',
          material: (_, __) => MaterialAppData(
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: materialTheme,
            darkTheme: materialDarkTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: cupertinoTheme,
          ),
          home: ProjectsScreen(),
        ),
      );
  }
}
