import 'package:flutter/material.dart';

import 'button_group.dart';

class SectorsActionBar extends StatelessWidget {
  final List _sections = ['A', 'B', 'C', 'D'];
  final Function? onFilterPressed;
  final Function? onActionPressed;

  SectorsActionBar(
      {Key? key, required this.onFilterPressed, required this.onActionPressed})
      : super(key: key);

  List<Map<String, dynamic>> getSectionButtons() {
    return List.generate(
        _sections.length,
        (index) => {
              'key': Key(_sections[index]),
              'width': 40.0,
              'height': 40.0,
              'widget': Text(_sections[index])
            });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Filter:'),
          ButtonGroup(onPressed: onFilterPressed, toggle: true, buttons: [
            const {
              'key': Key('all'),
              'width': 50.0,
              'height': 40.0,
              'widget': Text('All')
            },
            ...getSectionButtons()
          ]),
          ButtonGroup(onPressed: onActionPressed, buttons: const [
            {
              'key': Key('export'),
              'width': 40.0,
              'height': 40.0,
              'widget': Text('E'),
              'color': Colors.green
            },
            {
              'key': Key('clear'),
              'width': 40.0,
              'height': 40.0,
              'widget': Text('R'),
              'color': Colors.red
            }
          ])
        ],
      ),
    );
  }
}
