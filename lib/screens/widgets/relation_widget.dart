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
import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RelationWidget extends StatelessWidget {
  RelationWidget({this.dependency});

  final Dependency dependency;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: dependency.relation?.replaceAll('_', ' ') ?? 'Package',
      child: Badge(
        badgeContent: Text(
          dependency.issueCount.toString(),
          style: TextStyle(color: Colors.white),
        ),
        showBadge: dependency.issueCount > 0,
        child: Icon(_relationIcon[dependency.relation] ?? Icons.folder),
      ),
    );
  }
}

const _relationIcon = <String, IconData>{
  'unrelated': Icons.language,
  'independent': Icons.shopping_bag,
  'dynamic_link': Icons.link,
  'static_link': Icons.code,
  'modified_code': Icons.edit
};
