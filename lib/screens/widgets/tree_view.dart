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
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TreeView<T> extends StatefulWidget {
  TreeView({
    Key key,
    this.leading,
    @required this.data,
    @required this.children,
    this.builder,
  }) : super(key: key ?? ObjectKey(data));

  final T data;
  final List<T> Function(T data) children;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, T data) leading;

  @override
  _TreeViewState createState() => _TreeViewState<T>();
}

class _TreeViewState<T> extends State<TreeView<T>> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _widget(context),
          ),
          if (_expanded)
            Padding(
                padding: EdgeInsets.only(left: 50),
                child: Column(
                  children: widget
                      .children(widget.data)
                      .map((data) => TreeView<T>(
                            key: ObjectKey(data),
                            data: data,
                            leading: widget.leading,
                            children: widget.children,
                            builder: widget.builder,
                          ))
                      .toList(growable: false),
                ))
        ],
      );

  Widget _widget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          if (widget.leading != null)
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: widget.leading(context, widget.data),
                    onTap: _toggleExpand,
                  ),
                ),
              ),
            ),
          if (widget.builder != null)
            Expanded(child: widget.builder(context, widget.data))
          else
            Expanded(child: Text(widget.data.toString())),
          if (widget.children(widget.data).isNotEmpty)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: PlatformIconButton(
                icon: Icon(_expanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up),
                onPressed: _toggleExpand,
              ),
            )
        ],
      ),
    );
  }

  void _toggleExpand() {
    setState(() => _expanded = !_expanded);
  }
}
