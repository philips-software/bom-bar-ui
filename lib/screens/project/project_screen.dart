/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/project/info_card.dart';
import 'package:bom_bar_ui/screens/project/issues_card.dart';
import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'packages_card.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Project'),
      ),
      iosContentPadding: true,
      body: Consumer<ProjectService>(
        builder: (context, service, child) => service.current == null
            ? Center(child: PlatformCircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    InfoCard(service.current),
                    if (service.current.licenseIssues.isNotEmpty)
                      IssuesCard(service.current.licenseIssues),
                    if (service.current.dependencies.isNotEmpty)
                      PackagesCard(service.current.dependencies),
                  ],
                ),
              ),
      ),
    );
  }
}
