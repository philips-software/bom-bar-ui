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
import 'package:bom_bar_ui/screens/widgets/dependency_tile.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DependenciesCard extends StatelessWidget {
  DependenciesCard(this.dependencies, {this.title = 'Dependencies'});

  final List<Dependency> dependencies;
  final String title;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<DependencyService>(context, listen:false);

    return Card(
      child: Column(
        children: [
          ListTile(title: Text(title)),
          ...dependencies
              .map((dep) => DependencyTile(
                    dep,
                    onSelect: () => service.id = dep.id,
                  ))
              .toList(growable: false),
        ],
      ),
    );
  }
}
