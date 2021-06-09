import 'package:flutter/material.dart';

import 'button.dart';

class ButtonSection extends StatelessWidget {
  final String title;
  final Widget? button1;
  final Widget? button2;
  final VoidCallback? onButton1Pressed;
  final VoidCallback? onButton2Pressed;

  const ButtonSection(
      {Key? key,
      required this.title,
      this.button1,
      this.button2,
      this.onButton1Pressed,
      this.onButton2Pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 20)),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32))
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
                child: button1,
                width: 100,
                height: 100,
                onPressed: onButton1Pressed),
            Button(
                child: button2,
                width: 100,
                height: 100,
                onPressed: onButton2Pressed),
          ],
        )
      ],
    );
  }
}
