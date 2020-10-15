/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/dependency/dependency_screen.dart';
import 'package:bom_bar_ui/screens/widgets/dependency_view.dart';
import 'package:bom_bar_ui/screens/widgets/relation_widget.dart';
import 'package:bom_bar_ui/screens/widgets/tree_view.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Project'),
      ),
      body: Consumer<ProjectService>(
        builder: (context, service, child) => service.current == null
            ? Center(child: Text('(No project selected)'))
            : ListView(
                children: service.current.dependencies
                    .map(
                      (dependency) => TreeView(
                        data: dependency,
                        children: (d) => d.dependencies,
                        leading: (_, d) => RelationWidget(
                          dependency: d,
                        ),
                        builder: (_, dep) => DependencyView(
                          dependency: dep,
                          onTap: (d) {
                            Provider.of<DependencyService>(context,
                                    listen: false)
                                .id = d.id;
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
    );
  }
}
