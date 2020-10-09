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

import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SnapshotWidget<T> extends StatelessWidget {
  SnapshotWidget({Key key, @required this.snapshot, @required this.builder})
      : super(key: key);

  final Widget Function(BuildContext context, T data) builder;
  final AsyncSnapshot<T> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return ErrorWidget(snapshot.error);
    }
    if (!snapshot.hasData) {
      return Center(
        child: PlatformCircularProgressIndicator(),
      );
    }
    return builder(context, snapshot.data);
  }
}
