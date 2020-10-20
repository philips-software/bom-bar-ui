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
import 'package:bom_bar_ui/screens/dependency/dependency_screen.dart';
import 'package:bom_bar_ui/screens/widgets/dependencies_tree.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class PackagesCard extends StatelessWidget {
  PackagesCard(this.dependencies);

  final List<Dependency> dependencies;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<DependencyService>(context, listen: false);

    return Card(
      child: Column(
        children: [
          ListTile(title: Text('Packages')),
          DependenciesTree(
            dependencies,
            onTap: (d) {
              service.id = d.id;
              Navigator.push(
                  context,
                  platformPageRoute(
                      context: context, builder: (_) => DependencyScreen()));
            },
          )
        ],
      ),
    );
  }
}
