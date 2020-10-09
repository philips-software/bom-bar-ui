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
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TreeView<T extends TreeNode> extends StatefulWidget {
  TreeView({Key key, @required this.data, this.builder, this.isRoot = true})
      : super(key: key ?? ObjectKey(data));

  final bool isRoot;
  final T data;
  final Widget Function(BuildContext context, TreeNode<T> node) builder;

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState<T extends TreeNode> extends State<TreeView<T>> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) => widget.isRoot
      ? SingleChildScrollView(child: _build(context))
      : _build(context);

  Widget _build(BuildContext context) => Column(
        children: [
          _widget(context, widget.data),
          if (_expanded)
            Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  children: widget.data
                      .getChildren()
                      .map((data) => TreeView<T>(
                          key: ObjectKey(data),
                          data: data,
                          builder: widget.builder,
                          isRoot: false))
                      .toList(growable: false),
                ))
        ],
      );

  Widget _widget(BuildContext context, TreeNode data) {
    if (widget.builder != null) {
      return widget.builder(context, data);
    }

    return Material(
      child: ListTile(
        title: Text(data.toString()),
        trailing: data.getChildren().isNotEmpty
            ? PlatformIconButton(
                icon: Icon(_expanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right),
                onPressed: () => expand(!_expanded),
              )
            : null,
      ),
    );
  }

  void expand(bool value) {
    setState(() => this._expanded = value);
  }
}

abstract class TreeNode<T> {
  List<T> getChildren();
}
