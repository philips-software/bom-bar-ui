/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppUI extends StatelessWidget {
  AppUI({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOM-bar',
      // themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.purple.shade50,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        accentColor: Colors.purpleAccent[100],
        indicatorColor: Colors.purpleAccent[100],
        toggleableActiveColor: Colors.purpleAccent[100],
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
