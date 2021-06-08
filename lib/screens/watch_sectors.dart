import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchSectors extends StatefulWidget {
  const WatchSectors({required Key key}) : super(key: key);

  @override
  _WatchSectorsState createState() => _WatchSectorsState();
}

class _WatchSectorsState extends State<WatchSectors> {
  List _sectors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Parking Site')),
        body: Column(
          children: [],
        ));
  }
}
