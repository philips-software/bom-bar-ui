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
  final baseUrl = Uri.http(kIsWeb ? '' : 'localhost:8081', '/');
  final _dio = Dio();

  Future<List<Project>> getProjects() async {
    var data = await _request(() {
      log('GET all projects');
      return _dio.get(baseUrl.resolve('projects').toString());
    });
    return toProjectList(data['results']);
  }

  Future<Project> getProject(String id) async {
    return toProject(await _request(() {
      log('GET project $id');
      return _dio.get(baseUrl.resolve('projects/$id').toString());
    }));
  }

  Future<Dependency> getDependency(String projectId, String id) async {
    return toDependency(await _request(() {
      log('GET dependency $id');
      return _dio.get(
          baseUrl.resolve('projects/$projectId/dependencies/${Uri.encodeComponent(id)}').toString());
    }));
  }

  Future<T> _request<T>(Future<Response<T>> Function() func) async {
    try {
      final response = await func();
      switch (response.statusCode) {
        case 200:
        case 201:
          return response.data;
        default:
          throw Exception(
              'Server responded with ${response.statusCode}: ${response.statusMessage}');
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw e;
    }
  }
}
