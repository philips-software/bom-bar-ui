/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../model/project.dart';
import '../../services/project_service.dart';
import '../project/project_screen.dart';

class ProjectsList extends StatelessWidget {
  ProjectsList(this.projects, {Key key}) : super(key: key);

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final service = ProjectService.of(context);

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Material(
          child: ListTile(
            leading: Badge(
              badgeContent: Text(
                project.issueCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              showBadge: project.issueCount > 0,
              child: Icon(PlatformIcons(context).home),
            ),
            title: Text(project.title),
            subtitle: Text('Phase: ${project.phase.name}'),
            onTap: () {
              service.select(project.id);
              Navigator.push(
                  context,
                  platformPageRoute(
                    context: context,
                    builder: (_) => ProjectScreen(),
                  ));
            },
          ),
        );
      },
    );
  }
}
