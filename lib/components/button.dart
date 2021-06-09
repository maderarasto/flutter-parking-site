import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final bool disabled;
  final VoidCallback? onPressed;
  final Widget? child;

  Button({
    Key? key,
    this.width = 30,
    this.height = 30,
    this.disabled = false,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        child: child,
      ),
    );
  }
}
