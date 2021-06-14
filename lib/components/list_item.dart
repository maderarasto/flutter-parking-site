import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final EdgeInsets padding;
  final List<Widget> children;

  const ListItem(
      {Key? key,
      this.padding = const EdgeInsets.all(0),
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
