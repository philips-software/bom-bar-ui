/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/domain/project.dart';
import 'package:bom_bar_ui/screens/dependency/dependency_screen.dart';
import 'package:bom_bar_ui/screens/widgets/dependency_view.dart';
import 'package:bom_bar_ui/screens/widgets/relation_widget.dart';
import 'package:bom_bar_ui/screens/widgets/snapshot_widget.dart';
import 'package:bom_bar_ui/screens/widgets/tree_view.dart';
import 'package:bom_bar_ui/services/bom_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen();

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<BomService>(context, listen: false);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Project'),
      ),
      body: StreamBuilder(
        stream: service.project,
        builder: (context, AsyncSnapshot<Project> snapshot) =>
            SnapshotWidget<Project>(
          snapshot: snapshot,
          builder: (context, project) => ListView(
            children: project.packages
                .map(
                  (dependency) => TreeView(
                    data: dependency,
                    children: (d) => d.dependencies,
                    leading: (_, d) => RelationWidget(
                      relation: d.relation,
                    ),
                    builder: (_, dep) => DependencyView(
                      dependency: dep,
                      onTap: (d) {
                        service.dependencyId = d.id;
                        return Navigator.push(
                          context,
                          platformPageRoute(
                              context: context,
                              builder: (_) => DependencyScreen()));
                      },
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}
