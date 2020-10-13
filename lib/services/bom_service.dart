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

import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:bom_bar_ui/domain/project.dart';
import 'package:bom_bar_ui/services/bombar_client.dart';

import 'cache_stream.dart';

class BomService {
  BomService() {
    _projectStream = cached(_projectController.stream);
    _dependencyStream = cached(_dependencyController.stream);
  }

  final _client = BomBarClient();
  final _projectController = StreamController<Project>();
  final _dependencyController = StreamController<Dependency>();

  Stream<Project> _projectStream;
  Stream<Dependency> _dependencyStream;
  String _projectId;
  String _dependencyId;

  String get projectId => _projectId;

  set projectId(String id) {
    _client.getProject(id).then((project) {
      _projectController.add(project);
      _projectId = id;
    }).catchError((error) => _projectController.addError(error));
  }

  Stream<Project> get project => _projectStream;

  String get dependencyId => _dependencyId;

  set dependencyId(String id) {
    _client.getDependency(_projectId, id).then((dependency) {
      _dependencyController.add(dependency);
      _dependencyId = id;
    }).catchError((error) => _dependencyController.addError(error));
  }

  Stream<Dependency> get dependency => _dependencyStream;

  Future<List<Project>> projects() async => _client.getProjects();

  void dispose() {
    _projectController.close();
    _dependencyController.close();
  }
}
