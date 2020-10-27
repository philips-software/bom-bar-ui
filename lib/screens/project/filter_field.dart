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

  final Function(String filter, bool onlyErrors) onChanged;

  @override
  _FilterFieldState createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  final _controller = TextEditingController();
  var _onlyErrors = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: PlatformTextField(
                    controller: _controller,
                    onChanged: (value) => widget.onChanged(value, _onlyErrors),
                    autofocus: true,
                    material: (_, __) => MaterialTextFieldData(
                          decoration: InputDecoration(
                            hintText: 'Filter',
                          ),
                        ),
                    cupertino: (_, __) => CupertinoTextFieldData(
                          placeholder: 'Filter',
                        )),
              ),
            ),
            PlatformIconButton(
              icon: Icon(PlatformIcons(context).clear),
              onPressed: () {
                _controller.clear();
                widget.onChanged('', _onlyErrors);
              },
            )
          ],
        ),
        SwitchListTile.adaptive(
          value: _onlyErrors,
          title: Text('Show only errors'),
          onChanged: (value) => setState(() {
            _onlyErrors = value;
            widget.onChanged(_controller.text, value);
          }),
        ),
      ],
    );
  }
}
