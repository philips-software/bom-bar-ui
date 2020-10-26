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
import 'package:bom_bar_ui/screens/widgets/dependency_view.dart';
import 'package:bom_bar_ui/screens/widgets/relation_widget.dart';
import 'package:bom_bar_ui/screens/widgets/tree_view.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DependenciesCard extends StatelessWidget {
  DependenciesCard(this.service);

  final DependencyService service;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(title: Text('Dependencies')),
          ...service.current.dependencies
              .map(
                (dep) => TreeView<Dependency>(
                  data: dep,
                  children: (d) => d.dependencies,
                  leading: (_, d) => RelationWidget(dependency: d),
                  builder: (context, d) => DependencyView(
                    dependency: d,
                    onTap: (d) => service.id = d.id,
                  ),
                ),
              )
              .toList(growable: false),
        ],
      ),
    );
  }
}
