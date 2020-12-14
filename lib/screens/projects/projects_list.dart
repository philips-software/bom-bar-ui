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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/project.dart';
import '../app_routes.dart';

class ProjectsList extends StatelessWidget {
  ProjectsList(this.projects, {Key key}) : super(key: key);

  static final dateFormat = DateFormat.yMMMMEEEEd().add_Hm();

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        final lastUpdate = (project.lastUpdate != null)
            ? dateFormat.format(project.lastUpdate)
            : '(never)';

        return Material(
          child: ListTile(
            leading: Badge(
              badgeContent: Text(
                project.issueCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              showBadge: project.issueCount > 0,
              child: Icon(Icons.home),
            ),
            title:
                Text(project.title.isNotEmpty ? project.title : '(Untitled)'),
            subtitle: Text(
              'Updated: $lastUpdate\n'
              'Phase: ${project.phase.name}',
            ),
            isThreeLine: true,
            onTap: () {
              Navigator.popAndPushNamed(context, projectRoute,
                  arguments: project.id);
            },
          ),
        );
      },
    );
  }
}
