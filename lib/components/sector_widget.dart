import 'package:flutter/material.dart';

import 'button.dart';
import '../local_db.dart';

class SectorWidget extends StatefulWidget {
  final String sector;

  const SectorWidget({required Key key, required this.sector})
      : super(key: key);

  @override
  _SectorWidgetState createState() => _SectorWidgetState();
}

class _SectorWidgetState extends State<SectorWidget> {
  int _cars = 0;

  @override
  void initState() {
    super.initState();

    LocalDB.db.get('sectors',
        whereSql: 'letter = ?', parameters: [widget.sector]).then((result) {
      for (var sectorItem in result) {
        setState(() {
          _cars += sectorItem['type'] == 'arrival' ? 1 : -1;
        });
      }
    });
  }

  void onMinusPressed() async {
    var object = {
      'letter': widget.sector,
      'type': 'departure',
      'created_at': DateTime.now().toString()
    };

    await LocalDB.db.insert('sectors', object);
    setState(() {
      _cars -= 1;
    });
  }

  void onPlusPressed() async {
    var object = {
      'letter': widget.sector,
      'type': 'arrival',
      'created_at': DateTime.now().toString()
    };

    await LocalDB.db.insert('sectors', object);
    setState(() {
      _cars += 1;
    });
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
                child: const Icon(Icons.remove, color: Colors.white, size: 36),
                disabled: _cars == 0),
            Button(
                onPressed: onPlusPressed,
                width: 70,
                height: 70,
                child: const Icon(Icons.add, color: Colors.white, size: 36))
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 5))
      ],
    );
  }
}
