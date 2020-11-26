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

import '../model/dependency.dart';
import '../model/project.dart';

const _distributions = {
  Distribution.internal: 'internal',
  Distribution.open_source: 'open_source',
  Distribution.proprietary: 'proprietary',
  Distribution.saas: 'saas'
};

const _phases = {Phase.development: 'development', Phase.released: 'released'};

Project toProject(Map<String, Object> map) => Project(
      id: map['id'],
      title: map['title'] ?? '?',
      lastUpdate: toDateTime(map['updated']),
      distribution: toDistribution(map['distribution']),
      phase: toPhase(map['phase']),
      issueCount: map['issues'] ?? 0,
      dependencies: toDependencyList(map['packages'] ?? []),
    );

DateTime toDateTime(String iso) {
  if (iso == null) {
    return null;
  }
  return DateTime.parse(iso);
}

Distribution toDistribution(String value) {
  value = value.toLowerCase();
  return _distributions.entries
          .firstWhere((element) => element.value == value, orElse: () => null)
          ?.key ??
      Distribution.unknown;
}

Phase toPhase(String value) {
  value = value.toLowerCase();
  return _phases.entries
          .firstWhere((element) => element.value == value, orElse: () => null)
          ?.key ??
      Phase.unknown;
}

List<Project> toProjectList(List<dynamic> list) =>
    list?.map((map) => toProject(map))?.toList(growable: false);

Map<String, Object> fromProject(Project project) => {
      'id': project.id,
      'title': project.title,
      'distribution': _distributions[project.distribution],
      'phase': _phases[project.phase],
    };

Dependency toDependency(Map<String, Object> map) => Dependency(
      id: map['id'],
      title: map['title'] ?? '?',
      purl: toUrl(map['purl']),
      version: map['version'] ?? '',
      license: map['license'] ?? '',
      relation: map['relation'],
      issueCount: map['issues'] ?? 0,
      licenseIssues: toStringList(map['license_issues'] ?? []),
      dependencies: toDependencyList(map['dependencies'] ?? []),
      usages: toDependencyList(map['usages'] ?? []),
    );

Package toPackage(Map<String, Object> map) => Package(
      id: map['id'],
      title: map['name'] ?? '?',
      vendor: map['vendor'] ?? '(unknown)',
      homepage: toUrl(map['homepage']),
      approval: toApproval(map['approval'] ?? '?'),
    );

List<Package> toPackageList(List<dynamic> list) =>
    list.map((pkg) => toPackage(pkg)).toList(growable: false);

Uri toUrl(String string) => (string != null) ? Uri.parse(string) : null;

List<Dependency> toDependencyList(List<dynamic> list) =>
    list.map((map) => toDependency(map)).toList(growable: false);

List<String> toStringList(List<Object> list) =>
    list.map((s) => s.toString()).toList(growable: false);

Approval toApproval(String approval) {
  switch (approval) {
    case 'context':
      return Approval.context;
    case 'rejected':
      return Approval.rejected;
    case 'needs_approval':
      return Approval.confirmation;
    case 'approved':
      return Approval.accepted;
    default:
      log('Adapting approval "$approval"', error: 'No mapping defined');
      return Approval.context;
  }
}
