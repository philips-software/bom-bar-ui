/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/foundation.dart';

class Dependency {
  Dependency({
    this.id,
    this.title,
    this.purl,
    this.version,
    this.license,
    this.relation,
    this.issueCount = 0,
    this.licenseIssues = const [],
    this.dependencies = const [],
    this.usages = const [],
  });

  final String id;
  final String title;
  final Uri purl;
  final String version;
  final String license;
  final String relation;
  final int issueCount;
  final List<String> licenseIssues;
  final List<Dependency> dependencies;
  final List<Dependency> usages;

  int get totalIssues {
    return issueCount +
        (dependencies
                ?.map((dep) => dep.totalIssues)
                ?.fold(0, (l, r) => l + r) ??
            0);
  }
}
