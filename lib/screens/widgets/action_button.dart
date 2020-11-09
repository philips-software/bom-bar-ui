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

class ActionButton extends StatelessWidget {
  ActionButton({this.icon = Icons.edit, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        icon: Icon(icon),
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.only(left: 8),
        constraints: BoxConstraints(),
        onPressed: onPressed,
      ),
    );
  }
}
