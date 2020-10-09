/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'dart:developer';

import 'package:bom_bar_ui/domain/package.dart';
import 'package:bom_bar_ui/domain/project.dart';
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
      body: StreamBuilder(
        stream: service.project,
        builder: (context, AsyncSnapshot<Project> snapshot) =>
            SnapshotWidget<Project>(
          snapshot: snapshot,
          builder: (context, project) => SingleChildScrollView(
            child: Column(
              children: project.packages
                  .map((package) => TreeView(
                        data: package,
                        children: (package) => package.dependencies,
                        leading: (_, package) => _relation(package),
                        builder: (_, package) => _PackageView(package: package),
                        isRoot: false,
                      ))
                  .toList(growable: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _relation(Package package) {
    return Tooltip(
      message: package.relation?.replaceAll('_', ' ') ?? 'Package',
      child: Icon(<String, IconData>{
            'unrelated': Icons.language,
            'independent': Icons.shopping_bag,
            'dynamic_link': Icons.link,
            'static_link': Icons.code,
            'modified_code': Icons.edit
          }[package.relation] ??
          Icons.folder),
    );
  }
}

class _PackageView extends StatelessWidget {
  _PackageView({this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          package.title,
          style: theme.headline6,
        ),
        Text('Version: ${package.version}', style: theme.subtitle1),
        Text('License: ${package.license}', style: theme.subtitle2)
      ],
    );
  }
}
