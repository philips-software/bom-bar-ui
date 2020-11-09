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
import 'package:provider/provider.dart';

import 'screens/app_ui.dart';
import 'services/backend_service.dart';
import 'services/bombar_client.dart';
import 'services/dependency_service.dart';
import 'services/project_service.dart';

void main() {
  runApp(BomBarApplication());
}

final _client = BomBarClient();
final _backendService = BackendService(client: _client);
final _projectService = ProjectService(client: _client);
final _dependencyService =
    DependencyService(projectService: _projectService, client: _client);

class BomBarApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => _backendService),
        ChangeNotifierProvider(create: (_) => _projectService),
        ChangeNotifierProvider(create: (_) => _dependencyService),
      ],
      child: AppUI(),
    );
  }
}
