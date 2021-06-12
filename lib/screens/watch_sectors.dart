import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/sector_widget.dart';

class WatchSectors extends StatelessWidget {
  const WatchSectors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Parking Site'),
      ),
      body: Column(
        children: [
          SectorWidget(key: UniqueKey(), sector: 'A'),
          SectorWidget(key: UniqueKey(), sector: 'B'),
          SectorWidget(key: UniqueKey(), sector: 'C'),
          SectorWidget(key: UniqueKey(), sector: 'D'),
        ],
      ),
    );
  }
}
