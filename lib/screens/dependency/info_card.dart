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
import 'package:bom_bar_ui/screens/widgets/action_button.dart';
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
              Text(dependency.title, style: style.headline4),
              if (dependency.purl != null)
                Text(dependency.purl.toString(), style: style.bodyText2),
              Text('SPDX ID: ${dependency.id}'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(dependency.version.isNotEmpty
                    ? 'Version: ${dependency.version}'
                    : '(No version)'),
              ),
              Text(dependency.license.isNotEmpty
                  ? 'License: ${dependency.license}'
                  : '(No license)'),
            ],
          ),
          trailing: (dependency.package != null)
              ? ActionButton(
                  icon: Icons.chevron_right,
                  onPressed: () => Navigator.of(context).pushNamed(packageRoute,
                      arguments: dependency.package.id),
                )
              : null,
        ),
      ],
    ));
  }
}
