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

import 'package:bom_bar_ui/domain/project.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model_adapters.dart';

class BomBarClient {
  final baseUrl = Uri.http(kIsWeb ? '' : 'localhost:8081', '/');
  final _client = Dio();

  Future<List<Project>> getProjects() async {
    log('GET all projects');
    final response = await _client.get(baseUrl.resolve('projects').toString());
    return toProjectList(response.data['results']);
  }

  Future<Project> getProject(String id) async {
    try {
      log('GET project $id');
      final response =
      await _client.get(baseUrl.resolve('projects/$id').toString());
      return toProject(response.data);
    } catch (e,s) {
      log(e.toString(),stackTrace: s);
      throw e;
    }
  }
}
