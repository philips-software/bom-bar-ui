/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/widgets/app_drawer.dart';
import 'package:bom_bar_ui/services/package_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';
import 'info_card.dart';
import 'projects_card.dart';

class PackageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isRoot = !Navigator.of(context).canPop();

    return Scaffold(
      appBar: AppBar(
        title: Text('Package'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, packagesRoute, (route) => false),
          )
        ],
      ),
      drawer: isRoot ? AppDrawer() : null,
      body: Consumer<PackageService>(
        builder: (context, service, _) {
          if (service.error != null) {
            return ErrorWidget(service.error);
          }
          if (service.current == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              InfoCard(service.current),
              Flexible(child: ProjectsCard(service.current)),
            ],
          );
        },
      ),
    );
  }
}
