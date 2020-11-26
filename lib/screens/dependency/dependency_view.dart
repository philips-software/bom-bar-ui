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
import 'package:provider/provider.dart';

import '../../services/dependency_service.dart';
import 'dependencies_card.dart';
import 'info_card.dart';
import 'issues_card.dart';

class DependencyView extends StatefulWidget {
  @override
  _DependencyViewState createState() => _DependencyViewState();
}

class _DependencyViewState extends State<DependencyView>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DependencyService>(
      builder: (context, service, child) {
        final dependency = service.current;
        return dependency == null
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoCard(dependency),
                  if (dependency.licenseIssues.isNotEmpty)
                    IssuesCard(dependency.licenseIssues),
                  TabBar(
                    controller: _controller,
                    tabs: [
                      Text('Depends on'),
                      Text('Dependency of'),
                    ],
                  ),
                  Flexible(
                    child: Card(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          DependenciesCard(dependency.dependencies,
                              title: 'Depends on'),
                          DependenciesCard(dependency.usages,
                              title: 'Dependency of'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
