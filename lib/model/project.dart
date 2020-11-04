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

class Project {
  Project({
    @required this.id,
    this.title,
    this.lastUpdate,
    this.distribution,
    this.phase,
    this.issueCount,
    this.dependencies,
  });

  final String id;
  String title;
  final DateTime lastUpdate;
  final Distribution distribution;
  final Phase phase;
  final int issueCount;
  final List<Dependency> dependencies;
}

enum Distribution { open_source, internal, saas, proprietary, unknown }

extension DistributionName on Distribution {
  String get name => _name(this);
}

enum Phase { development, released, unknown }

extension PhaseName on Phase {
  String get name => _name(this);
}

String _name(dynamic object) => object.toString().split('.').last.toUpperCase();
