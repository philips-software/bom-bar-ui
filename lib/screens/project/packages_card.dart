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
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../model/dependency.dart';
import '../../services/dependency_service.dart';
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
  List<Dependency> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.dependencies;
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<DependencyService>(context, listen: false);
    final packageCount = (_filtered.length != widget.dependencies.length)
        ? '${_filtered.length}/${widget.dependencies.length}'
        : widget.dependencies.length.toString();

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(title: Text('Packages ($packageCount)')),
          FilterField(onChanged: _filter),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _filtered
                  .map((dep) => DependencyTile(
                        dep,
                        onSelect: () => service.id = dep.id,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _filter(String filter, bool onlyErrors) {
    filter = filter.toLowerCase();
    setState(() {
      _filtered = widget.dependencies
          .where((dep) => dep.title.toLowerCase().contains(filter))
          .where((dep) => !onlyErrors || dep.issueCount > 0)
          .toList(growable: false);
    });
  }
}
