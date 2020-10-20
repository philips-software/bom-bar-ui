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

import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:bom_bar_ui/domain/project.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model_adapters.dart';

class BomBarClient {
  static final baseUrl = Uri.http(kIsWeb ? '' : 'localhost:8081', '/');
  static final projectsUrl = baseUrl.resolve('projects/');
  final _dio = Dio();

  BomBarClient() {
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
        logPrint: (o) => log(o),
      ));
    }
  }

  Future<List<Project>> getProjects() async {
    var response = await _dio.getUri(projectsUrl);
    return toProjectList(response.data['results']);
  }

  Future<Project> getProject(String id) async {
    var response = await _dio.getUri(projectsUrl.resolve(id));
    return toProject(response.data);
  }

  Future<Project> createProject() async {
    var response = await _dio.postUri(projectsUrl, data: {});
    return toProject(response.data);
  }

  Future<Dependency> getDependency(String projectId, String id) async {
    var response = await _dio.getUri(projectsUrl
        .resolve('$projectId/dependencies/${Uri.encodeComponent(id)}'));
    return toDependency(response.data);
  }
}
