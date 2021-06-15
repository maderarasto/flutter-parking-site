import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter_parking_site/local_db.dart' show LocalDB, ResultSet;
import '../components/data_bar.dart';
import '../components/list_item.dart';
import '../components/alert.dart';

class MeasureTimesData extends StatefulWidget {
  const MeasureTimesData({Key? key}) : super(key: key);

  @override
  _MeasureTimesDataState createState() => _MeasureTimesDataState();
}

class _MeasureTimesDataState extends State<MeasureTimesData> {
  List<ResultSet> _data = [];

  @override
  initState() {
    super.initState();
    LocalDB.db
        .get('queue_times')
        .then((result) => setState(() => _data = result));
  }

  TextStyle getListItemTextStyle() {
    return const TextStyle(fontSize: 18);
  }

  void onFilterButtonPressed(Map<String, dynamic> button) async {}

  void onAlertCancelPressed() {
    debugPrint('Cancel');
  }

  void onAlertConfirmPressed() async {
    await LocalDB.db.delete('queue_times');
    List<ResultSet> result = await LocalDB.db.get('queue_times');

    setState(() {
      _data = result;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Clearing measure times data successful'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    void onExportPressed() async {
      List<ResultSet> data = await LocalDB.db.get('queue_times');
      Directory documentsDir = await getApplicationDocumentsDirectory();
      File exportedFile = File('${documentsDir.path}/queue_times_export.csv');

      for (var item in data) {
        String row = '${item['created_at']};${item['duration']};';
        await exportedFile.writeAsString('$row\n');
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Export measure times data successful'),
        backgroundColor: Colors.green,
      ));
    }

    void onClearPressed() {
      showDialog(
        context: context,
        builder: (BuildContext context) => Alert(
          title: const Text('Clear data'),
          content: const Text('Are you sure you want to clear data?'),
          onCancel: onAlertCancelPressed,
          onConfirm: onAlertConfirmPressed,
        ),
      );
    }

    void onActionButtonPressed(Map<String, dynamic> button) async {
      if (button['key'] == const Key('export')) {
        onExportPressed();
      } else if (button['key'] == const Key('clear')) {
        onClearPressed();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Parking Site'),
      ),
      body: Column(
        children: [
          DataBar(
            padding: const EdgeInsets.all(10),
            onFilterPressed: onFilterButtonPressed,
            onActionPressed: onActionButtonPressed,
          ),
          Expanded(
            child: _data.isEmpty
                ? const Center(
                    child: Text(
                      'There is no queue times data listed.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
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
                              Text(
                                  '${_data[index]['duration'].toStringAsFixed(2)} seconds',
                                  style: getListItemTextStyle()),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
