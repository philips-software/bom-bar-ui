/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/app_routes.dart';
import 'package:flutter/material.dart';

import '../../model/dependency.dart';

class InfoCard extends StatelessWidget {
  InfoCard(this.dependency);

  final Dependency dependency;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Card(
        child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.folder),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${dependency.title} ${dependency.version ?? "(no version)"}',
                  style: style.headline4),
              Text('SPDX ID: ${dependency.id}'),
              if (dependency.purl != null) Text(dependency.purl.toString()),
              SizedBox(height: 8),
              Text(dependency.license.isNotEmpty
                  ? 'License: ${dependency.license}'
                  : '(No license)'),
            ],
          ),
        ),
        ButtonBar(
          children: [
            if (dependency.package != null)
              TextButton.icon(
                icon: Icon(Icons.folder),
                label: Text('VIEW PACKAGE'),
                onPressed: () => Navigator.of(context)
                    .pushNamed(packageRoute, arguments: dependency.package.id),
              )
          ],
        )
      ],
    ));
  }
}
