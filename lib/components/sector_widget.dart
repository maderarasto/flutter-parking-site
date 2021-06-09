import 'package:flutter/material.dart';
import 'dart:math';

import 'button.dart';

class SectorWidget extends StatefulWidget {
  final String sector;
  final Function(String)? onMinusPressed;
  final Function(String)? onPlusPressed;

  const SectorWidget(
      {required Key key,
      required this.sector,
      this.onMinusPressed,
      this.onPlusPressed})
      : super(key: key);

  @override
  _SectorWidgetState createState() => _SectorWidgetState();
}

class _SectorWidgetState extends State<SectorWidget> {
  int _cars = 0;

  void onMinusPressed() {
    setState(() {
      _cars -= 1;
    });

    widget.onMinusPressed!(widget.sector);
  }

  void onPlusPressed() {
    setState(() {
      _cars += 1;
    });

    widget.onPlusPressed!(widget.sector);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              Text('Sector ${widget.sector}',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(left: 5, right: 5)),
              Text('$_cars cars')
            ]),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
                onPressed: onMinusPressed,
                width: 70,
                height: 70,
                child: const Text('-'),
                disabled: _cars == 0),
            Button(
                onPressed: onPlusPressed,
                width: 70,
                height: 70,
                child: const Text('+'))
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 5))
      ],
    );
  }
}
