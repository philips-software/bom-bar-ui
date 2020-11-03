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

import '../model/dependency.dart';
import 'bombar_client.dart';
import 'project_service.dart';

class DependencyService extends ChangeNotifier {
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

  //TODO change to select(String value)
  set id(String value) {
    if (_projectService.current == null) return;

    _client.getDependency(_projectService.current.id, value).then((dep) {
      current = dep;
      log('Selected dependency $value');
      notifyListeners();
    }).catchError((error) => log(error.toString()));
  }
}
