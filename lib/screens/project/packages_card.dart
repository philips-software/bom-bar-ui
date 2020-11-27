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
import 'package:flutter/rendering.dart';

import '../../model/dependency.dart';
import '../widgets/dependency_tile.dart';
import 'filter_field.dart';

class PackagesCard extends StatefulWidget {
  PackagesCard(this.dependencies, {this.onSelect});

  final List<Dependency> dependencies;
  final Function(Dependency dependency) onSelect;

  @override
  _PackagesCardState createState() => _PackagesCardState();
}

class _PackagesCardState extends State<PackagesCard> {
  String _filter = '';
  bool _onlyErrors = false;

  @override
  Widget build(BuildContext context) {
    final filtered = widget.dependencies
        .where((dep) => dep.title.toLowerCase().contains(_filter))
        .where((dep) => !_onlyErrors || dep.issueCount > 0)
        .toList(growable: false);
    final packageCount = (filtered.length != widget.dependencies.length)
        ? '${filtered.length}/${widget.dependencies.length}'
        : widget.dependencies.length.toString();

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(title: Text('Packages ($packageCount)')),
          FilterField(onChanged: _onFilterChange),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: filtered
                  .map((dep) => DependencyTile(
                        dep,
                        onSelect: () => widget.onSelect(dep),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _onFilterChange(String filter, bool onlyErrors) {
    setState(() {
      _filter = filter.toLowerCase();
      _onlyErrors = onlyErrors;
    });
  }
}
