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

class EditTextDialog {
  EditTextDialog({this.title, this.value, this.lines = 1});

  final String title;
  final String value;
  final int lines;

  Future<String> show(BuildContext context) {
    final controller = TextEditingController(text: value);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 300,
          child: TextField(
            controller: controller,
            autofocus: true,
            autocorrect: true,
            minLines: lines,
            maxLines: lines,
          ),
        ),
        actions: [
          TextButton(
              child: Text('CANCEL'), onPressed: () => Navigator.pop(context)),
          TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context, controller.text)),
        ],
      ),
    );
  }
}
