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
import 'package:bom_bar_ui/screens/project/project_screen.dart';
import 'package:bom_bar_ui/services/bom_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ProjectsList extends StatelessWidget {
  ProjectsList(this.projects, {Key key}) : super(key: key);

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<BomService>(context, listen: false);

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Material(
          type: MaterialType.transparency,
          child: ListTile(
            leading: Icon(PlatformIcons(context).home),
            title: Text(project.title),
            onTap: () {
              service.selectProject(project.id);
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
