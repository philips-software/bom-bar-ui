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

import '../model/project.dart';
import 'bombar_client.dart';

class ProjectService extends ChangeNotifier {
  ProjectService({BomBarClient client}) : _client = client ?? BomBarClient();

  final BomBarClient _client;
  Project current;

  Future<void> createNew() async {
    current = await _client.createProject();
    log('Created new project ${current.id}');
    notifyListeners();
  }

  Future<void> select(String id) async {
    current = await _client.getProject(id);
    log('Selected project $id');
    notifyListeners();
  }

  Future<void> uploadSpdx() async {
    await _client.uploadSpdx(current.id);
    log('Uploaded SPDX file');
    select(current.id);
  }
}
