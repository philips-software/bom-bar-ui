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
import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_card.dart';
import 'packages_card.dart';

class ProjectView extends StatelessWidget {
  ProjectView({this.onSelect});

  final Function(Dependency dependency) onSelect;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProjectService>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        children: [
          InfoCard(service.current),
          if (service.current.dependencies.isNotEmpty)
            PackagesCard(
              service.current.dependencies,
              onSelect: onSelect,
            ),
        ],
      ),
    );
  }
}
