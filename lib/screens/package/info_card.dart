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
import 'package:bom_bar_ui/screens/package/approval_tile.dart';
import 'package:bom_bar_ui/screens/widgets/edit_text_dialog.dart';
import 'package:bom_bar_ui/screens/widgets/shared.dart';
import 'package:bom_bar_ui/services/package_service.dart';
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
          ApprovalTile(package),
          ButtonBar(
            children: [
              TextButton.icon(
                icon: Icon(Icons.shield),
                label: Text('EXEMPT LICENSE'),
                onPressed: () => _exemptLicense(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _exemptLicense(BuildContext context) async {
    final license =
        await EditTextDialog(title: 'License to exempt').show(context);
    if (license != null) {
      PackageService.of(context)
          .exempt(license)
          .catchError((error) => showError(context, error));
    }
  }
}
