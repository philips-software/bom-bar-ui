/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'dart:async';
import 'dart:developer';

import 'package:bom_bar_ui/model/package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'bombar_client.dart';

class PackageService extends ChangeNotifier {
  factory PackageService.of(BuildContext context) =>
      Provider.of<PackageService>(context, listen: false);

  PackageService({BomBarClient client}) : _client = client ?? BomBarClient();

  final BomBarClient _client;
  Package _current;

  Package get current => _current;

  Future<void> select(String id) async {
    _current = await _client.getPackage(id);
    log('Selected package $id');
    notifyListeners();
  }
}
