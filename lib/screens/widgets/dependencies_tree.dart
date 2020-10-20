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
import 'package:flutter/widgets.dart';

import 'dependency_view.dart';
import 'relation_widget.dart';
import 'tree_view.dart';

class DependenciesTree extends StatelessWidget {
  DependenciesTree(this.dependencies, {this.onTap});

  final List<Dependency> dependencies;
  final Function(Dependency dependency) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      dependencies
          .map(
            (dep) =>
            TreeView<Dependency>(
              data: dep,
              children: (d) => d.dependencies,
              leading: (_, d) => RelationWidget(dependency: d),
              builder: (context, d) =>
                  DependencyView(
                    dependency: d,
                    onTap: onTap,
                  ),
            ),
      ).toList(growable: false),
    );
  }
}

