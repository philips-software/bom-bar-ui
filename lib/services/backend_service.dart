/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import '../model/project.dart';
import 'bombar_client.dart';

class BackendService {
  BackendService({this.client});

  final BomBarClient client;

  Future<List<Project>> projects() async => client.getProjects();
}
