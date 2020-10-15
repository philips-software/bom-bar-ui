/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:bom_bar_ui/screens/widgets/dependency_view.dart';
import 'package:bom_bar_ui/screens/widgets/relation_widget.dart';
import 'package:bom_bar_ui/screens/widgets/tree_view.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'dependencies_card.dart';

class DependencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Dependency'),
      ),
      body: Consumer<DependencyService>(
        builder: (context, service, child) => service.current == null
            ? Center(child: Text('(No dependency selected'))
            : ListView(children: [
               Text(service.current.title, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline4),
                DependenciesCard(service),
              ]),
      ),
    );
  }
}
