/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/domain/package.dart';
import 'package:bom_bar_ui/domain/project.dart';
import 'package:bom_bar_ui/screens/widgets/snapshot_widget.dart';
import 'package:bom_bar_ui/screens/widgets/tree_view.dart';
import 'package:bom_bar_ui/services/bom_service.dart';
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
                  .map((package) => PackageNode(package))
                  .map((node) => TreeView(
                        data: node,
                        isRoot: false,
                      ))
                  .toList(growable: false),
            ),
          ),
        ),
      ),
    );
  }
}

class PackageNode implements TreeNode {
  PackageNode(this.package);

  final Package package;

  @override
  List getChildren() =>
      package.dependencies.map((p) => PackageNode(p)).toList(growable: false);

  @override
  String toString() {
    return '${package.title} version ${package.version}';
  }
}
