/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/dependency.dart';
import '../../services/dependency_service.dart';
import '../widgets/dependency_tile.dart';

class DependenciesCard extends StatelessWidget {
  DependenciesCard(this.dependencies, {this.title = 'Dependencies'});

  final List<Dependency> dependencies;
  final String title;

  @override
  Widget build(BuildContext context) {
    final service = DependencyService.of(context);

    return dependencies.isNotEmpty
        ? ListView.builder(
            itemCount: dependencies.length,
            itemBuilder: (context, index) {
              final dependency = dependencies[index];
              return DependencyTile(
                dependency,
                onSelect: () => service.select(dependency.id),
              );
            })
        : Center(child: Text('(None)'));
  }
}
