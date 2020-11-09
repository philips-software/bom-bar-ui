/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:flutter/material.dart';

import '../../model/dependency.dart';

class DependencyView extends StatelessWidget {
  DependencyView({this.dependency, this.onTap});

  final Dependency dependency;
  final Function(Dependency package) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => onTap?.call(dependency),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: dependency.title,
                style: theme.headline6,
              ),
              TextSpan(
                text: ' - ${dependency.version}',
                style: theme.subtitle1,
              ),
            ]),
          ),
          Text('License: ${dependency.license}', style: theme.subtitle2),
        ],
      ),
    );
  }
}
