import 'package:flutter/material.dart';

import 'button_group.dart';

class DataBar extends StatelessWidget {
  final EdgeInsets padding;
  final List<Map<String, dynamic>> filterButtons;
  final Function? onFilterPressed;
  final Function? onActionPressed;

  const DataBar(
      {Key? key,
      this.padding = const EdgeInsets.all(0),
      this.filterButtons = const [],
      this.onFilterPressed,
      required this.onActionPressed})
      : super(key: key);

  List<Widget> getFilterWidgets() {
    if (filterButtons.isEmpty) return [];

    return [
      const Text('Filter:'),
      ButtonGroup(onPressed: onFilterPressed, toggle: true, buttons: [
        const {
          'key': Key('all'),
          'width': 50.0,
          'height': 40.0,
          'widget': Text('All')
        },
        ...filterButtons
      ]),
    ];
  }

  MainAxisAlignment resolveRowAlignment() {
    return filterButtons.isEmpty
        ? MainAxisAlignment.end
        : MainAxisAlignment.spaceBetween;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: resolveRowAlignment(),
        children: [
          ...getFilterWidgets(),
          ButtonGroup(onPressed: onActionPressed, buttons: const [
            {
              'key': Key('export'),
              'width': 40.0,
              'height': 40.0,
              'widget': Icon(Icons.download, color: Colors.white, size: 24),
              'color': Colors.green
            },
            {
              'key': Key('clear'),
              'width': 40.0,
              'height': 40.0,
              'widget':
                  Icon(Icons.delete_forever, color: Colors.white, size: 24),
              'color': Colors.red
            }
          ])
        ],
      ),
    );
  }
}
