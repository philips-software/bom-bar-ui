/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */
import 'package:bom_bar_ui/screens/widgets/action_item.dart';
import 'package:bom_bar_ui/screens/widgets/edit_selection_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

import '../../model/project.dart';
import '../../services/project_service.dart';
import '../widgets/edit_text_dialog.dart';
import 'upload_widget.dart';

class InfoCard extends StatelessWidget {
  static final dateFormat = DateFormat.yMMMMEEEEd().add_Hm();

  InfoCard(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(PlatformIcons(context).info),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionItem(
                  child: Text(project.title, style: style.headline4),
                  onPressed: () => _editTitle(context),
                ),
                if (project.issueCount > 0)
                  Text(
                    '${project.issueCount} license errors',
                    style: TextStyle(color: Colors.red),
                  ),
                ActionItem(
                  child: Text('UUID: ${project.id}'),
                  icon: Icons.copy,
                  onPressed: () =>
                      Clipboard.setData(new ClipboardData(text: project.id)),
                ),
                ActionItem(
                  child: Text('Phase: ${project.phase.name}'),
                  onPressed: () => _editPhase(context),
                ),
                ActionItem(
                  child: Text('Distribution: ${project.distribution.name}'),
                  onPressed: () => _editDistribution(context),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (project.lastUpdate != null)
                      Text(
                          'Last update: ${dateFormat.format(project.lastUpdate)}')
                    else
                      Text('(No bill-of-materials imported yet)'),
                    if (kIsWeb) UploadWidget(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editTitle(BuildContext context) {
    EditTextDialog(title: 'Project title', value: project.title)
        .show(context)
        .then((value) {
      if (value != null) {
        final service = ProjectService.of(context);
        service.update(Project(id: project.id, title: value));
      }
    });
  }

  void _editPhase(BuildContext context) {
    _editBySelection(
        context: context,
        title: 'Project phase',
        items: Map.fromIterable(
            Phase.values.where((element) => element != Phase.unknown),
            key: (v) => v,
            value: (v) => (v as Phase).name),
        value: project.phase,
        projectFrom: (p) => Project(id: project.id, phase: p));
  }

  void _editDistribution(BuildContext context) {
    _editBySelection<Distribution>(
      context: context,
      title: 'Target distribution',
      items: Map.fromIterable(
          Distribution.values
              .where((element) => element != Distribution.unknown),
          key: (v) => v,
          value: (v) => (v as Distribution).name),
      value: project.distribution,
      projectFrom: (d) => Project(id: project.id, distribution: d),
    );
  }

  void _editBySelection<T>({
    @required BuildContext context,
    String title,
    Map<T, String> items,
    T value,
    Project Function(T value) projectFrom,
  }) {
    EditSelectionDialog(title: title, values: items, selection: value)
        .show(context)
        .then((result) {
      if (result != null) {
        final service = ProjectService.of(context);
        service.update(projectFrom(result));
      }
    });
  }
}
