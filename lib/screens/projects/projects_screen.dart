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
import 'package:bom_bar_ui/screens/projects/projects_list.dart';
import 'package:bom_bar_ui/screens/widgets/snapshot_widget.dart';
import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  ProjectService service;
  Future<List<Project>> projects;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service = Provider.of<ProjectService>(context);
    projects = service.projects();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('All projects'),
      ),
      body: FutureBuilder(
        future: projects,
        builder: (context, snapshot) =>
            SnapshotWidget(
              snapshot: snapshot,
              builder: (context, list) => ProjectsList(list),
            ),
      ),
    );
  }
}
