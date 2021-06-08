import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'watch_sectors.dart';

class Home extends StatelessWidget {
  const Home({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onWatchSectorsPressed() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WatchSectors(key: UniqueKey())));
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Flutter Parking Site',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 72),
          ),
          SizedBox(
            height: 400,
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(30),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              children: <Widget>[
                ElevatedButton(
                    onPressed: onWatchSectorsPressed,
                    child: const Text('Watch Sectors')),
                ElevatedButton(
                    onPressed: null, child: const Text('Measure Queue Times')),
                ElevatedButton(
                    onPressed: null, child: const Text('Sectors Data')),
                ElevatedButton(
                    onPressed: null, child: const Text('Measure Data')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
