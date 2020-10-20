/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/domain/issue.dart';
import 'package:bom_bar_ui/screens/dependency/dependency_screen.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class IssuesCard extends StatelessWidget {
  IssuesCard(this.issues);

  final List<Issue> issues;

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
                    title: Text(issue.title),
                    subtitle: Text(issue.description),
                    trailing: (issue.id != null)
                        ? Icon(PlatformIcons(context).rightChevron)
                        : null,
                    onTap: (issue.id != null)
                        ? () {
                            service.id = issue.id;
                            Navigator.push(
                                context,
                                platformPageRoute(
                                    context: context,
                                    builder: (_) => DependencyScreen()));
                          }
                        : null,
                  ))
              .toList(growable: false),
        ],
      ),
    );
  }
}
