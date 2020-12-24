/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/model/project.dart';
import 'package:flutter/material.dart';

class ProjectIcon extends StatelessWidget {
  ProjectIcon(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Icon(_projectIcons[project.phase] ?? Icons.warning);
  }
}

final _projectIcons = {
  Phase.development: Icons.build,
  Phase.released: Icons.check_circle,
};
