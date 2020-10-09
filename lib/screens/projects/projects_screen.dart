/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/screens/projects/projects_list.dart';
import 'package:bom_bar_ui/screens/widgets/snapshot_widget.dart';
import 'package:bom_bar_ui/services/bom_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<BomService>(context);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Projects'),
      ),
      body: FutureBuilder(
        future: service.projects(),
        builder: (context, snapshot) => SnapshotWidget(
          snapshot: snapshot,
          builder: (context, list) => ProjectsList(list),
        ),
      ),
    );
  }
}
