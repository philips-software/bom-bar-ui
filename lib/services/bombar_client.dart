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

import 'package:bom_bar_ui/model/package.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:flutter/foundation.dart';

import '../model/dependency.dart';
import '../model/project.dart';
import '../plugins/file_uploader.dart';
import 'model_adapters.dart';

class BomBarClient {
  static final baseUrl =
      Uri.http(kIsWeb && !kDebugMode ? '' : 'localhost:8081', '/');
  static final projectsUrl = baseUrl.resolve('projects/');
  static final packagesUrl = baseUrl.resolve('packages/');
  static final _approvals = {
    Approval.context: 'context',
    Approval.rejected: 'rejected',
    Approval.confirmation: 'needs_approval',
    Approval.accepted: 'approved',
    Approval.noPackage: 'not_a_package',
  };

  final _dio = Dio()..transformer = FlutterTransformer();

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
    final response = await _dio.getUri(projectsUrl);
    return toProjectList(response.data['results']);
  }

  Future<Project> createProject() async {
    final response = await _dio.postUri(projectsUrl, data: {});
    return toProject(response.data);
  }

  Future<Project> getProject(String id) async {
    final response = await _dio.getUri(projectsUrl.resolve(id));
    return toProject(response.data);
  }

  Future<Project> updateProject(Project project) async {
    final response = await _dio.putUri(
      projectsUrl.resolve(project.id),
      data: fromProject(project),
    );
    return toProject(response.data);
  }

  Future<void> uploadSpdx(String id) =>
      FileUploader(projectsUrl.resolve('$id/upload')).upload();

  Future<Dependency> getDependency(String projectId, String id) async {
    final response =
        await _dio.getUri(projectsUrl.resolve('$projectId/dependencies/$id'));
    return toDependency(response.data);
  }

  Future<List<Package>> findPackagesById({String filter}) async {
    final response = await _dio.getUri(packagesUrl.resolve('?id=$filter'));
    return toPackageList(response.data['results']);
  }

  Future<Package> getPackage(String id) async {
    final response = await _dio.getUri(packagesUrl.resolve(id));
    return toPackage(response.data);
  }

  Future<void> setApproval(String packageId, Approval approval) {
    final value = _approvals[approval];
    return _dio.postUri(packagesUrl.resolve('$packageId/approve/$value'));
  }
}
