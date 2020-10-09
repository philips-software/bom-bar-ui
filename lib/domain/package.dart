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

class Package {
  Package(
      {@required this.id,
      @required this.title,
      @required this.version,
      this.dependencies = const []});

  final String id;
  final String title;
  final version;
  final List<Package> dependencies;
}
