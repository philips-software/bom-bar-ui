/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IssuesCard extends StatelessWidget {
  IssuesCard(this.issues);

  final List<String> issues;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<DependencyService>(context, listen: false);

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('License issues (${issues.length})'),
          ),
          ...issues
              .map((issue) => ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    title: Text(
                      issue,
                      style: TextStyle(color: Colors.red),
                    ),
                  ))
              .toList(growable: false),
        ],
      ),
    );
  }
}
