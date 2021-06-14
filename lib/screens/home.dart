import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'watch_sectors.dart';
import 'measure_time.dart';
import 'sectors_data.dart';

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

    void onMeasureTimePressed() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeasureTime(key: UniqueKey())));
    }

    void onSectorsDataPressed() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SectorsData(key: UniqueKey())));
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
                    child: const Text(
                      'Watch Sectors',
                      textAlign: TextAlign.center,
                    )),
                ElevatedButton(
                    onPressed: onMeasureTimePressed,
                    child: const Text(
                      'Measure Queue Times',
                      textAlign: TextAlign.center,
                    )),
                ElevatedButton(
                    onPressed: onSectorsDataPressed,
                    child: const Text(
                      'Sectors Data',
                      textAlign: TextAlign.center,
                    )),
                ElevatedButton(
                    onPressed: null,
                    child: const Text(
                      'Measure Data',
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
