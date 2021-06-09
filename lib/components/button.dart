import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback? onPressed;
  final bool disabled;

  Button(
      {Key? key,
      this.width = 30,
      this.height = 30,
      this.text = 'button',
      this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }
}
