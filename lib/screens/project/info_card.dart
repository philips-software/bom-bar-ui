/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../model/project.dart';
import 'upload_widget.dart';

class InfoCard extends StatelessWidget {
  InfoCard(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(PlatformIcons(context).info),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: style.headline4),
                if (project.issueCount > 0)
                  Text(
                    '${project.issueCount} license errors',
                    style: TextStyle(color: Colors.red),
                  ),
                Row(
                  children: [
                    Text('UUID: ${project.id}'),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: PlatformIconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(
                            new ClipboardData(text: project.id)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (project.lastUpdate != null)
                      Text('Last update: ${project.lastUpdate.toLocal()}')
                    else
                      Text('(No bill-of-materials imported yet)'),
                    if (kIsWeb) UploadWidget(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
