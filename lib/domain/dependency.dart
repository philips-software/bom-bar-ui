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
  Dependency(
      {@required this.id,
      @required this.title,
      @required this.version,
      @required this.license,
      this.relation,
      this.issueCount,
      this.dependencies = const []});

  final String id;
  final String title;
  final String version;
  final String license;
  final String relation;
  final int issueCount;
  final List<Dependency> dependencies;
}
