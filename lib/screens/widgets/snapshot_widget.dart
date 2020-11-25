/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'dart:developer';

import 'package:flutter/material.dart';

class SnapshotWidget<T> extends StatelessWidget {
  SnapshotWidget(this.snapshot, {Key key, @required this.builder})
      : super(key: key);

  final AsyncSnapshot<T> snapshot;
  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      log('Snapshot failed:', error: snapshot.error.toString());
      return ErrorWidget(snapshot.error);
    }
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return builder(context, snapshot.data);
  }
}
