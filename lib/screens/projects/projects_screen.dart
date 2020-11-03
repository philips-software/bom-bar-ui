/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../model/project.dart';
import '../../services/backend_service.dart';
import '../../services/project_service.dart';
import '../project/project_screen.dart';
import '../widgets/snapshot_widget.dart';
import 'projects_list.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  BackendService backendService;
  ProjectService projectService;
  Future<List<Project>> projects;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    backendService = BackendService.of(context);
    projectService = ProjectService.of(context);
    projects = backendService.projects();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('All projects'),
        cupertino: (context, __) => CupertinoNavigationBarData(
          trailing: PlatformIconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () => _createProject(context),
          ),
        ),
      ),
      body: FutureBuilder(
        future: projects,
        builder: (context, snapshot) => SnapshotWidget(
          snapshot,
          builder: (context, list) => ProjectsList(list),
        ),
      ),
      material: (_, __) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createProject(context),
        ),
      ),
    );
  }

  void _createProject(BuildContext context) {
    projectService.createNew().then((_) {
      setState(() {
        projects = backendService.projects();
      });
    });
    Navigator.push(context,
        platformPageRoute(context: context, builder: (_) => ProjectScreen()));
  }
}
