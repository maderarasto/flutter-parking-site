import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_parking_site/local_db.dart' show LocalDB, ResultSet;
import '../components/sectors_action_bar.dart';
import '../components/list_item.dart';
import '../components/alert.dart';

class SectorsData extends StatefulWidget {
  const SectorsData({Key? key}) : super(key: key);

  @override
  _SectorsDataState createState() => _SectorsDataState();
}

class _SectorsDataState extends State<SectorsData> {
  List<ResultSet> _data = [];

  @override
  initState() {
    super.initState();
    loadSectorsData().then((result) => setState(() => _data = result));
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

    debugPrint('Confirm');
  }

  @override
  Widget build(BuildContext context) {
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
      } else if (button['key'] == const Key('clear')) {
        onClearPressed();
      }
    }

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
