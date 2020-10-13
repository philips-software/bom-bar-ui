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
  Project({@required this.id, @required this.title, this.packages = const []});

  final String id;
  String title;
  final List<Dependency> packages;
}
