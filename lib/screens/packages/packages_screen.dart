/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/model/package.dart';
import 'package:bom_bar_ui/screens/widgets/app_drawer.dart';
import 'package:bom_bar_ui/screens/widgets/snapshot_widget.dart';
import 'package:bom_bar_ui/services/backend_service.dart';
import 'package:flutter/material.dart';

import 'name_filter.dart';

class PackagesScreen extends StatefulWidget {
  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NameFilter(
          hint: 'package name fragment',
          onChanged: (fragment) => setState(() {
            filter = fragment;
          }),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: BackendService.of(context).packages(filter),
        builder: (context, snapshot) => SnapshotWidget<List<Package>>(
          snapshot,
          builder: (context, list) {
            return (list.isNotEmpty)
                ? ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.folder),
                      title: Text(list[index].title),
                      subtitle: Text(list[index].vendor),
                    ),
                  )
                : Center(child: Text('(No matching packages found)'));
          },
        ),
      ),
    );
  }
}
