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
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FilterField extends StatefulWidget {
  FilterField({this.onChanged});

  final Function(String filter) onChanged;

  @override
  _FilterFieldState createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0),
            child: PlatformTextField(
              controller: controller,
              onChanged: widget.onChanged,
              autofocus: true,
              material: (_,__)=> MaterialTextFieldData(
                decoration: InputDecoration(
                  hintText: 'Filter',
                ),
              ),
              cupertino: (_,__)=> CupertinoTextFieldData(
                placeholder: 'Filter',
              )
            ),
          ),
        ),
        PlatformIconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            controller.clear();
            widget.onChanged('');
          },
        )
      ],
    );
  }
}
