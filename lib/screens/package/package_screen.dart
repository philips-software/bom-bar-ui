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

import 'info_card.dart';

class PackageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isRoot = !Navigator.of(context).canPop();

    return Scaffold(
      appBar: AppBar(
        title: Text('Package'),
      ),
      drawer: isRoot ? AppDrawer() : null,
      body: Consumer<PackageService>(
        builder: (context, service, _) => (service.current == null)
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  InfoCard(service.current),
                ],
              ),
      ),
    );
  }
}
