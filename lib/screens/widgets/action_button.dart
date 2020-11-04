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
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ActionButton extends StatelessWidget {
  ActionButton({this.icon = Icons.edit, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: PlatformIconButton(
        icon: Icon(icon),
        padding: EdgeInsets.only(left: 8),
        cupertino: (_, __) => CupertinoIconButtonData(
          minSize: 0,
        ),
        material: (_, __) => MaterialIconButtonData(
          constraints: BoxConstraints(),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
