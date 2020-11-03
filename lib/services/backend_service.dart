/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/project.dart';
import 'bombar_client.dart';

class BackendService {
  factory BackendService.of(BuildContext context) =>
      Provider.of<BackendService>(context, listen: false);

  BackendService({this.client});

  final BomBarClient client;

  Future<List<Project>> projects() async => client.getProjects();
}
