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
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../services/dependency_service.dart';
import '../../services/project_service.dart';
import '../dependency/dependency_screen.dart';
import '../dependency/dependency_view.dart';
import 'info_card.dart';
import 'packages_card.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1000;
    final dependencyService = DependencyService.of(context);

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
