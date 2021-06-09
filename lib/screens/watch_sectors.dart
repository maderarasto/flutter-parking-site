import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/sector_widget.dart';

class WatchSectors extends StatelessWidget {
  const WatchSectors({Key? key}) : super(key: key);

  onMinusPressed(String sector) {
    debugPrint('minus at $sector');
  }

  onPlusPressed(String sector) {
    debugPrint('plus at $sector');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Parking Site'),
      ),
      body: Column(
        children: [
          SectorWidget(
            key: UniqueKey(),
            sector: 'A',
            onMinusPressed: onMinusPressed,
            onPlusPressed: onPlusPressed,
          ),
          SectorWidget(
            key: UniqueKey(),
            sector: 'B',
            onMinusPressed: onMinusPressed,
            onPlusPressed: onPlusPressed,
          ),
          SectorWidget(
            key: UniqueKey(),
            sector: 'C',
            onMinusPressed: onMinusPressed,
            onPlusPressed: onPlusPressed,
          ),
          SectorWidget(
            key: UniqueKey(),
            sector: 'D',
            onMinusPressed: onMinusPressed,
            onPlusPressed: onPlusPressed,
          ),
        ],
      ),
    );
  }
}
