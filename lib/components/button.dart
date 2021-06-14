import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final bool active;
  final bool disabled;
  final VoidCallback? onPressed;
  final Widget? child;

  Button({
    Key? key,
    this.width = 30,
    this.height = 30,
    this.color = Colors.blue,
    this.active = false,
    this.disabled = false,
    required this.onPressed,
    required this.child,
  });

  Color? resolveColor() {
    Color resolvedColor = color ?? Colors.blue;

    if (active) {
      HSLColor hsl = HSLColor.fromColor(resolvedColor).withLightness(0.42);
      resolvedColor = hsl.toColor();
    }

    return resolvedColor;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(resolveColor()),
        ),
      ),
    );
  }
}
