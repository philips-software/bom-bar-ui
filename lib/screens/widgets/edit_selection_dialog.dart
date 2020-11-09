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

class EditSelectionDialog<T> {
  EditSelectionDialog({this.title, this.values, this.selection});

  final String title;
  final Map<T, String> values;
  T selection;

  Future<T> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: StatefulBuilder(
          builder: (context, setState) => Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: values.entries
                  .map(
                    (item) => Row(
                      children: [
                        Radio<T>(
                          value: item.key,
                          groupValue: selection,
                          onChanged: (v) => setState(() => selection = v),
                        ),
                        Text(item.value),
                      ],
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
        actions: [
          TextButton(
              child: Text('CANCEL'), onPressed: () => Navigator.pop(context)),
          TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context, selection)),
        ],
      ),
    );
  }
}
