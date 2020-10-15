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

import 'package:bom_bar_ui/domain/project.dart';
import 'package:bom_bar_ui/services/bombar_client.dart';
import 'package:flutter/foundation.dart';

class ProjectService extends ChangeNotifier {
  ProjectService({BomBarClient client}) : _client = client ?? BomBarClient();

  final BomBarClient _client;
  Project current;

  set id(String id) {
    _client.getProject(id).then((project) {
      current = project;
      log('Selected project $id');
      notifyListeners();
    }).catchError((error) => log(error));
  }

  //TODO Should this function remain here?
  Future<List<Project>> projects() async => _client.getProjects();
}
