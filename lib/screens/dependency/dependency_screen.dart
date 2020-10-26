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
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'dependencies_card.dart';
import 'info_card.dart';
import 'issues_card.dart';

class DependencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Dependency'),
      ),
      iosContentPadding: true,
      body: Consumer<DependencyService>(
          builder: (context, service, child) => service.current == null
              ? null
              : SingleChildScrollView(
                  child: Column(children: [
                  InfoCard(service.current),
                    if (service.current.licenseIssues.isNotEmpty)
                      IssuesCard(service.current.licenseIssues),
                  if (service.current.dependencies.isNotEmpty)
                    DependenciesCard(service),
                ]))),
    );
  }
}
