/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

class Package {
  Package({
    this.id,
    this.title,
    this.vendor,
    this.homepage,
    this.approval = Approval.context,
  });

  final String id;
  final String title;
  final String vendor;
  final Uri homepage;
  Approval approval;
}

enum Approval {
  rejected,
  confirmation,
  accepted,
  context,
}

extension ApprovalName on Approval {
  String get name => _name(this);
}

String _name(dynamic object) => object.toString().split('.').last.toUpperCase();
