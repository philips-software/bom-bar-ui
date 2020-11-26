/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/app_routes.dart';
import 'package:bom_bar_ui/screens/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/dependency_service.dart';
import '../../services/project_service.dart';
import '../dependency/dependency_view.dart';
import 'info_card.dart';
import 'packages_card.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1000;
    final dependencyService = DependencyService.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
      ),
      drawer: AppDrawer(),
      body: Consumer<ProjectService>(
        builder: (context, service, child) => service.current == null
            ? Center(child: CircularProgressIndicator())
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
                              child: PackagesCard(
                                service.current.dependencies,
                                onSelect: (d) {
                                  dependencyService.select(d.id).then((_) {
                                    if (!isWide) {
                                      Navigator.pushNamed(
                                          context, dependencyRoute);
                                    }
                                  });
                                },
                              ),
                            ),
                          if (isWide)
                            Flexible(
                              child: DependencyView(),
                            ),
                        ]),
                  ),
                ],
              ),
      ),
    );
  }
}
