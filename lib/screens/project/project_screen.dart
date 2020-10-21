/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/dependency/dependency_screen.dart';
import 'package:bom_bar_ui/screens/dependency/dependency_view.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'info_card.dart';
import 'packages_card.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1000;
    final dependencyService =
        Provider.of<DependencyService>(context, listen: true);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Project'),
      ),
      iosContentPadding: true,
      body: Consumer<ProjectService>(
        builder: (context, service, child) => service.current == null
            ? Center(child: PlatformCircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(service.current),
                  Expanded(
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (service.current.dependencies.isNotEmpty)
                            Flexible(
                              child: SingleChildScrollView(
                                child: PackagesCard(
                                  service.current.dependencies,
                                  onSelect: (d) {
                                    dependencyService.id = d.id;
                                    if (!isWide) {
                                      Navigator.push(
                                          context,
                                          platformPageRoute(
                                              context: context,
                                              builder: (_) =>
                                                  DependencyScreen()));
                                    }
                                  },
                                ),
                              ),
                            ),
                          if (isWide)
                            Flexible(
                              child: SingleChildScrollView(
                                child: DependencyView(),
                              ),
                            ),
                        ]),
                  ),
                ],
              ),
      ),
    );
  }
}
