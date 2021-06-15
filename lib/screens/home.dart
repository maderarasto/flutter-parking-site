import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'watch_sectors.dart';
import 'measure_time.dart';
import 'sectors_data.dart';
import 'measure_times_data.dart';

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

    void onMeasureTimesDataPressed() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeasureTimesData(key: UniqueKey())));
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.border_all_rounded,
                            color: Colors.white, size: 72),
                        Text('Watch Sectors', textAlign: TextAlign.center),
                      ],
                    )),
                ElevatedButton(
                    onPressed: onMeasureTimePressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.access_alarm_rounded,
                            color: Colors.white, size: 72),
                        Text(
                          'Measure Queue Times',
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                ElevatedButton(
                    onPressed: onSectorsDataPressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.view_list_rounded,
                            color: Colors.white, size: 72),
                        Text(
                          'Sectors Data',
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                ElevatedButton(
                    onPressed: onMeasureTimesDataPressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.view_list_rounded,
                            color: Colors.white, size: 72),
                        Text(
                          'Measured Times Data',
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
