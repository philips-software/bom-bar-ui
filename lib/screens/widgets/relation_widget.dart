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

import '../../model/dependency.dart';

class RelationWidget extends StatelessWidget {
  RelationWidget(this.dependency);

  final Dependency dependency;

  @override
  Widget build(BuildContext context) {
    final totalIssues = dependency.totalIssues;
    return Tooltip(
      message: dependency.relation?.replaceAll('_', ' ') ?? 'Package',
      child: Badge(
        badgeContent: Text(
          totalIssues.toString(),
          style: TextStyle(color: Colors.white),
        ),
        showBadge: totalIssues > 0,
        child: _iconFor(dependency.relation),
      ),
    );
  }

  Icon _iconFor(String relation) {
    return Icon(_relationIcon[relation] ??
        ((dependency.id != null) ? Icons.folder : Icons.folder_open_outlined));
  }
}

const _relationIcon = <String, IconData>{
  'unrelated': Icons.language,
  'independent': Icons.shopping_bag,
  'dynamic_link': Icons.link,
  'static_link': Icons.code,
  'modified_code': Icons.edit
};
