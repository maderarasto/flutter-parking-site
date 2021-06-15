import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';

import 'package:flutter_parking_site/local_db.dart' show LocalDB, ResultSet;
import 'package:path_provider/path_provider.dart';
import '../components/data_bar.dart';
import '../components/list_item.dart';
import '../components/alert.dart';

class SectorsData extends StatefulWidget {
  const SectorsData({Key? key}) : super(key: key);

  @override
  _SectorsDataState createState() => _SectorsDataState();
}

class _SectorsDataState extends State<SectorsData> {
  final List _sections = ['A', 'B', 'C', 'D'];
  List<ResultSet> _data = [];

  @override
  initState() {
    super.initState();
    loadSectorsData().then((result) => setState(() => _data = result));
  }

  List<Map<String, dynamic>> getSectionButtons() {
    return List.generate(
        _sections.length,
        (index) => {
              'key': Key(_sections[index]),
              'width': 40.0,
              'height': 40.0,
              'widget': Text(_sections[index])
            });
  }

  Future<List<ResultSet>> loadSectorsData({String filterBy = ''}) async {
    debugPrint('filterBy: $filterBy');
    String whereSql = '';
    List parameters = [];

    if (filterBy != '' && filterBy != 'all') {
      whereSql = 'letter = ?';
      parameters.add(filterBy);
    }

    return await LocalDB.db
        .get('sectors', whereSql: whereSql, parameters: parameters);
  }

  TextStyle getListItemTextStyle() {
    return const TextStyle(fontSize: 18);
  }

  String getFormattedDateTime(String stringifiedDate) {
    DateTime createdAt = DateTime.parse(stringifiedDate);
    String date = '${createdAt.day}. ${createdAt.month}. ${createdAt.year}';
    String time = '${createdAt.hour}:${createdAt.minute}:${createdAt.second}';

    return '$date $time';
  }

  Icon getItemTypeIcon(String type) {
    return type == 'arrival'
        ? const Icon(Icons.arrow_forward, color: Colors.green, size: 24)
        : const Icon(Icons.arrow_back, color: Colors.red, size: 24);
  }

  void onFilterButtonPressed(Map<String, dynamic> button) async {
    RegExp rule = RegExp(r"[[<]|[']|[>]]");
    String keyText = button['key'].toString().replaceAll(rule, '');
    List<ResultSet> result = await loadSectorsData(filterBy: keyText);

    setState(() {
      _data = result;
    });
  }

  void onAlertCancelPressed() {
    debugPrint('Cancel');
  }

  void onAlertConfirmPressed() async {
    await LocalDB.db.delete('sectors');
    List<ResultSet> result = await LocalDB.db.get('sectors');

    setState(() {
      _data = result;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Clearing sectors data successful'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    void onExportPressed() async {
      List<ResultSet> data = await loadSectorsData();
      Directory documentsDir = await getApplicationDocumentsDirectory();
      File exportedFile = File('${documentsDir.path}/sectors_export.csv');

      await exportedFile.writeAsString('', mode: FileMode.write);

      for (var item in data) {
        String row = '${item['created_at']};${item['type']};${item['letter']}';
        await exportedFile.writeAsString('$row\n', mode: FileMode.append);
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Export sectors data successful'),
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
              ));
    }

    void onActionButtonPressed(Map<String, dynamic> button) async {
      if (button['key'] == const Key('export')) {
        onExportPressed();
      } else if (button['key'] == const Key('clear')) {
        onClearPressed();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Parking Site')),
      body: Column(
        children: [
          DataBar(
            padding: const EdgeInsets.all(10),
            filterButtons: getSectionButtons(),
            onFilterPressed: onFilterButtonPressed,
            onActionPressed: onActionButtonPressed,
          ),
          Expanded(
            child: _data.isEmpty
                ? const Center(
                    child: Text('There is no sectors data listed.',
                        style: TextStyle(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListItem(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        children: [
                          Text(getFormattedDateTime(_data[index]['created_at']),
                              style: getListItemTextStyle()),
                          getItemTypeIcon(_data[index]['type']),
                          Row(
                            children: [
                              const Icon(Icons.door_sliding,
                                  color: Colors.grey, size: 24),
                              const Padding(padding: EdgeInsets.only(left: 5)),
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
