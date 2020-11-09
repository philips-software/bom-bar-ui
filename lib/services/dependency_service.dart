/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/dependency.dart';
import 'bombar_client.dart';
import 'project_service.dart';

class DependencyService extends ChangeNotifier {
  factory DependencyService.of(BuildContext context) =>
      Provider.of<DependencyService>(context, listen: false);

  DependencyService({ProjectService projectService, BomBarClient client})
      : _projectService = projectService,
        _client = client ?? BomBarClient() {
    _projectService.addListener(() {
      current = null;
      log('Cleared dependency selection');
      notifyListeners();
    });
  }

  final ProjectService _projectService;
  final BomBarClient _client;
  Dependency current;

  Future<void> select(String id) async {
    if (_projectService.current == null) return;

    current = await _client.getDependency(_projectService.current.id, id);
    log('Selected dependency $id');
    notifyListeners();
  }
}
