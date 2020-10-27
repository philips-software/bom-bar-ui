/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
          leading: Icon(PlatformIcons(context).folder),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dependency.title, style: style.headline4),
              Text(Uri.decodeComponent(dependency.id), style: style.bodyText2),
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
        ),
      ],
    ));
  }
}
