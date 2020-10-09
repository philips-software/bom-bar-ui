/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/domain/package.dart';
import 'package:bom_bar_ui/domain/project.dart';

Project toProject(Map<String, dynamic> map) => Project(
      id: map['id'],
      title: map['title'],
      packages: toPackageList(map['packages']),
    );

List<Project> toProjectList(List<dynamic> list) =>
    list?.map((map) => toProject(map))?.toList(growable: false);

Package toPackage(Map<String, dynamic> map) => Package(
      id: map['id'],
      title: map['title'],
      version: map['version'],
      dependencies: toPackageList(map['dependencies']),
    );

List<Package> toPackageList(List<dynamic> list) =>
    list?.map((map) => toPackage(map))?.toList(growable: false);
