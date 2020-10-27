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

import 'screens/app_theme.dart';

void main() {
  runApp(MyApp());
}

final _client = BomBarClient();
final _backendService = BackendService(client: _client);
final _projectService = ProjectService(client: _client);
final _dependencyService =
    DependencyService(projectService: _projectService, client: _client);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => _backendService),
        ChangeNotifierProvider(create: (_) => _projectService),
        ChangeNotifierProvider(create: (_) => _dependencyService),
      ],
      child: AppTheme(child: ProjectsScreen()),
    );
  }
}
