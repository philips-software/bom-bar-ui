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
import 'package:flutter/widgets.dart';

class RelationWidget extends StatelessWidget {
  RelationWidget({this.relation});

  final String relation;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: relation?.replaceAll('_', ' ') ?? 'Package',
      child: Icon(_relationIcon[relation] ?? Icons.folder),
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
