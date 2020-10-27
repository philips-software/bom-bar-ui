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
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'relation_widget.dart';

class DependencyTile extends StatelessWidget {
  DependencyTile(this.dep, {this.onSelect});

  final Dependency dep;
  final Function() onSelect;

  @override
  Widget build(BuildContext context) {
    bool hasId = dep.id != null;

    return ListTile(
      key: ValueKey(dep.id),
      dense: true,
      leading: RelationWidget(dep),
      title: Text('${dep.title} - ${dep.version}'),
      subtitle: Text('License: ${dep.license}'),
      trailing: (hasId) ? Icon(PlatformIcons(context).forward) : null,
      onTap: (hasId) ? onSelect : null,
    );
  }
}
