/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'package:bom_bar_ui/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class UploadWidget extends StatefulWidget {
  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

enum _Status { IDLE, DONE, ERROR }

class _UploadWidgetState extends State<UploadWidget> {
  var _status = _Status.IDLE;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlatformIconButton(
          icon: Icon(Icons.upload_file),
          onPressed: ()=>_onPressed(context),
        ),
        if (_status == _Status.DONE) Icon(Icons.check, color: Colors.green),
        if (_status == _Status.ERROR) Icon(Icons.error, color: Colors.red),
      ],
    );
  }

  void _onPressed(BuildContext context) {
    final service = Provider.of<ProjectService>(context, listen: false);

    nextState = _Status.IDLE;
    service
        .uploadSpdx()
        .then((_) => nextState = _Status.DONE)
        .catchError((_) => nextState = _Status.ERROR);
  }

  set nextState(_Status value) => setState(() {
        _status = value;
      });
}
