/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

const themeMode = ThemeMode.light;
// const themeMode = ThemeMode.dark;

class AppUI extends StatelessWidget {
  AppUI({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOM-bar',
      themeMode: kDebugMode ? themeMode : ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.purple.shade50,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        accentColor: Colors.purple,
        indicatorColor: Colors.purpleAccent,
        toggleableActiveColor: Colors.purpleAccent,
      ),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      initialRoute: '/projects',
    );
  }
}
