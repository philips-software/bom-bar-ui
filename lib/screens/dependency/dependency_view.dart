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

import 'dependencies_card.dart';
import 'info_card.dart';
import 'issues_card.dart';

class DependencyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DependencyService>(
      builder: (context, service, child) {
        final dependency = service.current;
        return dependency == null
            ? Container()
            : SingleChildScrollView(
                child: Column(children: [
                  InfoCard(dependency),
                  if (dependency.licenseIssues.isNotEmpty)
                    IssuesCard(dependency.licenseIssues),
                  if (dependency.dependencies.isNotEmpty)
                    DependenciesCard(dependency.dependencies,
                        title: 'Depends on'),
                  if (dependency.usages.isNotEmpty)
                    DependenciesCard(dependency.usages, title: 'Dependency of'),
                ]),
              );
      },
    );
  }
}
