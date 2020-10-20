/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// const platform = TargetPlatform.linux;
const platform = TargetPlatform.macOS;
const darkMode = false;

class AppTheme extends StatelessWidget {
  static final materialTheme = ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.purple.shade50,
  );
  static final materialDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
  );
  static final cupertinoTheme = CupertinoThemeData(
    brightness: darkMode ? Brightness.dark : Brightness.light,
    primaryColor: CupertinoDynamicColor.withBrightness(
      color: Colors.purple,
      darkColor: Colors.cyan,
    ),
    scaffoldBackgroundColor: Colors.purple.shade50,
  );

  AppTheme({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: materialTheme,
      child: PlatformProvider(
        initialPlatform: kDebugMode ? platform : null,
        builder: (context) => PlatformApp(
          title: 'BOM-bar',
          material: (_, __) => MaterialAppData(
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.materialTheme,
            darkTheme: AppTheme.materialDarkTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: AppTheme.cupertinoTheme,
          ),
          home: child,
        ),
      ),
    );
  }
}
