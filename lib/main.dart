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
import 'package:bom_bar_ui/services/backend_service.dart';
import 'package:bom_bar_ui/services/bombar_client.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

// const platform = null;
const platform = TargetPlatform.linux;
// const platform = TargetPlatform.macOS;
const darkMode = false;

void main() {
  runApp(MyApp());
}

final _client = BomBarClient();
final _backendService = BackendService(client: _client);
final _projectService = ProjectService(client: _client);
final _dependencyService =
    DependencyService(projectService: _projectService, client: _client);

class MyApp extends StatelessWidget {
  static final materialTheme = ThemeData(
    primarySwatch: Colors.purple,
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
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => _backendService),
        ChangeNotifierProvider(create: (_) => _projectService),
        ChangeNotifierProvider(create: (_) => _dependencyService),
      ],
      child: Theme(
        data: materialTheme,
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
