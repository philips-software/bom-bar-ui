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

class EditSelectionDialog<T> {
  EditSelectionDialog({this.title, this.values, this.selection});

  final String title;
  final Map<T, String> values;
  T selection;

  Future<T> show(BuildContext context) {
    return showPlatformDialog(
      context: context,
      builder: (context) => PlatformAlertDialog(
        title: Text(title),
        content: StatefulBuilder(
          builder: (context, setState) => Material(
            type: MaterialType.transparency,
            child: Column(
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
          PlatformDialogAction(
              child: PlatformText('Cancel'),
              onPressed: () => Navigator.pop(context)),
          PlatformDialogAction(
              child: PlatformText('OK'),
              onPressed: () => Navigator.pop(context, selection)),
        ],
      ),
    );
  }
}
