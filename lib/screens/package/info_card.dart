/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/model/package.dart';
import 'package:bom_bar_ui/screens/package/approval_card.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard(this.package);

  final Package package;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.info),
            title: Text(package.title,
                style: Theme.of(context).textTheme.headline4),
            subtitle: Text(package.vendor ?? '(Vendor unknown)'),
          ),
          ApprovalCard(package),
        ],
      ),
    );
  }
}
