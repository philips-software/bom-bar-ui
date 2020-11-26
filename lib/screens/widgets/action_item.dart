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

import 'action_button.dart';

class ActionItem extends StatelessWidget {
  ActionItem({this.child, this.icon = Icons.edit, this.onPressed});

  final Widget child;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        child,
        ActionButton(
          icon: icon,
          onPressed: onPressed,
        )
      ],
    );
  }
}
