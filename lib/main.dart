import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() => runApp(ParkingSite(key: UniqueKey()));

class ParkingSite extends StatelessWidget {
  const ParkingSite({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(key: UniqueKey()),
    );
  }
}
