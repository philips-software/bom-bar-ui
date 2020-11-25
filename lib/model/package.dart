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
  Package({this.id, this.title, this.vendor, this.homepage});

  final String id;
  final String title;
  final String vendor;
  final Uri homepage;
}
