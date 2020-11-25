/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/project.dart';
import 'bombar_client.dart';

class ProjectService extends ChangeNotifier {
  factory ProjectService.of(BuildContext context) =>
      Provider.of<ProjectService>(context, listen: false);

  ProjectService({BomBarClient client}) : _client = client ?? BomBarClient();

  final BomBarClient _client;
  Project _current;

  Project get current => _current;

  Future<void> createNew() async {
    _current = await _client.createProject();
    log('Created new project ${_current.id}');
    notifyListeners();
  }

  Future<void> select(String id) async {
    _current = await _client.getProject(id);
    log('Selected project $id');
    notifyListeners();
  }

  Future<void> update(Project update) async {
    _current = await _client.updateProject(update);
    log('Updated project ${_current.id}');
    notifyListeners();
  }

  Future<void> uploadSpdx() async {
    await _client.uploadSpdx(_current.id);
    log('Uploaded SPDX file');
    select(_current.id);
  }
}
