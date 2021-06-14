import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_parking_site/local_db.dart';

import '../components/sectors_action_bar.dart';
import '../components/list_item.dart';

class SectorsData extends StatefulWidget {
  const SectorsData({Key? key}) : super(key: key);

  @override
  _SectorsDataState createState() => _SectorsDataState();
}

class _SectorsDataState extends State<SectorsData> {
  List<Map<String, dynamic>> _data = [];

  @override
  initState() {
    super.initState();
    LocalDB.db.get('sectors').then((result) {
      setState(() => _data = result);
    });
  }

  TextStyle getListItemTextStyle() {
    return const TextStyle(fontSize: 18);
  }

  void onFilterButtonPressed(Map<String, dynamic> button) {
    debugPrint(button.toString());
  }

  void onActionButtonPressed(Map<String, dynamic> button) {
    debugPrint(button.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Parking Site')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: SectorsActionBar(
              onFilterPressed: onFilterButtonPressed,
              onActionPressed: onActionButtonPressed,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  children: [
                    Text(_data[index]['created_at'],
                        style: getListItemTextStyle()),
                    Row(
                      children: [
                        Text(_data[index]['type'][0].toUpperCase(),
                            style: getListItemTextStyle()),
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        Text('Sector ${_data[index]['letter']}',
                            style: getListItemTextStyle()),
                      ],
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
