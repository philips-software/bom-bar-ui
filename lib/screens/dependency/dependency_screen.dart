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
import 'package:bom_bar_ui/screens/widgets/snapshot_widget.dart';
import 'package:bom_bar_ui/screens/widgets/tree_view.dart';
import 'package:bom_bar_ui/services/bom_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class DependencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<BomService>(context);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Dependency'),
      ),
      body: StreamBuilder(
        stream: service.dependency,
        builder: (context, AsyncSnapshot<Dependency> snapshot) =>
            SnapshotWidget(
          snapshot: snapshot,
          builder: (context, Dependency dependency) => ListView(children: [
            Card(
              child: Column(
                children: dependency.dependencies.map((dep) =>
                  TreeView<Dependency>(
                    data: dep,
                    children: (d) => d.dependencies,
                    leading: (_, d) => RelationWidget(relation: d.relation),
                    builder: (context, d) => DependencyView(
                      dependency: d,
                      onTap: (d) => service.dependencyId = d.id,
                    ),
                  ),
                ).toList(growable: false),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
