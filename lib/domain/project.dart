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

import 'dependency.dart';
import 'issue.dart';

class Project {
  Project({
    @required this.id,
    @required this.title,
    this.issueCount,
    this.licenseIssues,
    this.dependencies,
  });

  final String id;
  String title;
  final int issueCount;
  final List<Issue> licenseIssues;
  final List<Dependency> dependencies;
}
