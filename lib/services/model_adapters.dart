/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:bom_bar_ui/domain/project.dart';

Project toProject(Map<String, dynamic> map) => Project(
      id: map['id'],
      title: map['title'] ?? '?',
      issueCount: map['issues'] ?? 0,
      dependencies: toDependencyList(map['packages'] ?? []),
    );

List<Project> toProjectList(List<dynamic> list) =>
    list?.map((map) => toProject(map))?.toList(growable: false);

Dependency toDependency(Map<String, dynamic> map) => Dependency(
      id: map['id'],
      title: map['title'] ?? '?',
      version: map['version'] ?? '',
      license: map['license'] ?? '',
      relation: map['relation'],
      issueCount: map['issues'] ?? 0,
      licenseIssues: toStringList(map['license_issues'] ?? []),
      dependencies: toDependencyList(map['dependencies'] ?? []),
    );

List<Dependency> toDependencyList(List<dynamic> list) =>
    list.map((map) => toDependency(map)).toList(growable: false);

List<String> toStringList(List<dynamic> list) =>
    list.map((s) => s.toString()).toList(growable: false);
