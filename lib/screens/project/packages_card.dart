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
import 'package:bom_bar_ui/screens/widgets/dependencies_tree.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PackagesCard extends StatelessWidget {
  PackagesCard(this.dependencies, {this.onSelect});

  final List<Dependency> dependencies;
  final Function(Dependency dependency) onSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(title: Text('Packages')),
          DependenciesTree(
            dependencies,
            onTap: onSelect,
          )
        ],
      ),
    );
  }
}