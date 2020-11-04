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

class EditTextDialog {
  EditTextDialog({this.title, this.value});

  final String title;
  final String value;

  Future<String> show(BuildContext context) {
    final controller = TextEditingController(text: value);

    return showPlatformDialog(
      context: context,
      builder: (context) => PlatformAlertDialog(
        title: Text(title),
        content: PlatformTextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          PlatformDialogAction(
              child: PlatformText('Cancel'),
              onPressed: () => Navigator.pop(context)),
          PlatformDialogAction(
              child: PlatformText('OK'),
              onPressed: () => Navigator.pop(context, controller.text)),
        ],
      ),
    );
  }
}
