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

import 'package:bom_bar_ui/domain/project.dart';
import 'package:bom_bar_ui/services/bombar_client.dart';

import 'cache_stream.dart';

class BomService {
  final _client = BomBarClient();
  final _projectController = StreamController<Project>();
  Stream<Project> _projectStream;

  BomService() {
    _projectStream = cached(_projectController.stream);
  }

  Stream<Project> get project => _projectStream;

  Future<List<Project>> projects() async => _client.getProjects();

  void selectProject(String projectId) {
    _client
        .getProject(projectId)
        .then((project) => _projectController.add(project))
        .catchError((error) => _projectController.addError(error));
  }

  void dispose() {
    _projectController.close();
  }
}
