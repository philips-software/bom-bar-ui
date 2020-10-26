/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:badges/badges.dart';
import 'package:bom_bar_ui/domain/dependency.dart';
import 'package:bom_bar_ui/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'filter_field.dart';

class PackagesCard extends StatefulWidget {
  PackagesCard(this.dependencies, {this.onSelect});

  final List<Dependency> dependencies;
  final Function(Dependency dependency) onSelect;

  @override
  _PackagesCardState createState() => _PackagesCardState();
}

class _PackagesCardState extends State<PackagesCard> {
  List<Dependency> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.dependencies;
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<DependencyService>(context, listen: false);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
              title: Text(
                  'Packages (${_filtered.length}/${widget.dependencies.length})')),
          FilterField(onChanged: (filter) => _filter(filter)),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _filtered
                  .map((dep) => ListTile(
                        key: ValueKey(dep.id),
                        dense: true,
                        leading: Badge(
                          showBadge: dep.issueCount > 0,
                          badgeContent: Text(
                            dep.issueCount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(Icons.folder),
                        ),
                        title: Text('${dep.title} - ${dep.version}'),
                        subtitle: Text('License: ${dep.license}'),
                        trailing: Icon(PlatformIcons(context).forward),
                        onTap: () => service.id = dep.id,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _filter(String filter) {
    filter = filter.toLowerCase();
    setState(() {
      _filtered = widget.dependencies
          .where((dep) => dep.title.toLowerCase().contains(filter))
          .toList(growable: false);
    });
  }
}
