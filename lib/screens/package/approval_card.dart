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

import '../../model/package.dart';
import '../../services/package_service.dart';
import '../widgets/action_item.dart';
import '../widgets/edit_selection_dialog.dart';

class ApprovalCard extends StatelessWidget {
  ApprovalCard(this.package);

  final Package package;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.verified_user),
      title: ActionItem(
        child: Text('Approval: ${_approvalMapping[package.approval]}'),
        onPressed: () => _editApproval(context),
      ),
    );
  }

  void _editApproval(BuildContext context) async {
    final update = await EditSelectionDialog<Approval>(
      title: 'Approval',
      values: _approvalMapping,
      selection: package.approval,
    ).show(context);
    if (update != null && update != package.approval) {
      PackageService.of(context).approval = update;
    }
  }
}

final _approvalMapping = {
  Approval.context: 'Depends on context (default)',
  Approval.confirmation: 'Requires confirmation',
  Approval.rejected: 'Never allowed',
  Approval.accepted: 'Always allowed',
  Approval.noPackage: 'Not a valid package',
};
