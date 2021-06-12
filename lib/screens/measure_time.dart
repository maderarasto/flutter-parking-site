import 'package:flutter/material.dart';

import '../components/button_section.dart';
import '../local_db.dart';

class MeasureTime extends StatefulWidget {
  const MeasureTime({Key? key}) : super(key: key);

  @override
  _MeasureTimeState createState() => _MeasureTimeState();
}

class _MeasureTimeState extends State<MeasureTime> {
  final List _queueCars = [];
  double _lastDuration = 0.0;

  void onTurningAwayPressed() async {
    var object = {
      'type': 'turning-away',
      'created_at': DateTime.now().toString()
    };

    await LocalDB.db.insert('departures', object);
    debugPrint('Turning Away');
  }

  void onLeavingPressed() async {
    var object = {'type': 'leaving', 'created_at': DateTime.now().toString()};

    await LocalDB.db.insert('departures', object);
    debugPrint('Leaving');
  }

  void onStartPressed() {
    var timestamp = DateTime.now().millisecondsSinceEpoch;

    setState(() {
      _queueCars.add(timestamp);
    });
  }

  void onStopPressed() async {
    int timestamp = _queueCars.first;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    double duration = (currentTime - timestamp) / 1000;

    var object = {
      'duration': duration,
      'created_at': DateTime.fromMillisecondsSinceEpoch(timestamp)
    };

    await LocalDB.db.insert('queue_times', object);

    setState(() {
      _queueCars.removeAt(0);
      _lastDuration = duration;
    });
  }

  Widget renderCarsQueue() {
    return Column(
        children: _queueCars.map((carTimestamp) {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(carTimestamp);

      return SizedBox(
          height: 40,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(dateTime.toLocal().toString(),
                style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(right: 20))
          ]));
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Parking Site'),
        ),
        body: Column(
          children: [
            ButtonSection(
              title: 'Departure Cars',
              button1: const Text('Turning Away', textAlign: TextAlign.center),
              button2: const Text('Leaving', textAlign: TextAlign.center),
              onButton1Pressed: onTurningAwayPressed,
              onButton2Pressed: onLeavingPressed,
            ),
            ButtonSection(
              title: 'Measure Queue Time',
              button1: const Text('Play', textAlign: TextAlign.center),
              button2: const Text('Stop', textAlign: TextAlign.center),
              onButton1Pressed: onStartPressed,
              onButton2Pressed: onStopPressed,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(
                'Last Waiting Time: ${_lastDuration.toStringAsFixed(2)} seconds.',
                style: const TextStyle(color: Colors.grey)),
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text('Cars Queue',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32))
                  ],
                ),
                renderCarsQueue()
              ],
            )
          ],
        ));
  }
}
