import 'package:flutter/material.dart';

import 'button.dart';

class ButtonGroup extends StatefulWidget {
  final List<Map<String, dynamic>> buttons;
  final Function? onPressed;
  final bool toggle;

  const ButtonGroup(
      {Key? key,
      required this.buttons,
      required this.onPressed,
      this.toggle = false})
      : super(key: key);

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  Key? _activeButtonKey;

  @override
  void initState() {
    super.initState();

    setState(() {
      _activeButtonKey = widget.buttons.first['key'];
    });
  }

  void onPressedHandler(Map<String, dynamic> button) {
    setState(() {
      _activeButtonKey = button['key'];
    });

    widget.onPressed!(button);
  }

  renderButtons() {
    List<Widget> renderedButtons = [];

    for (var button in widget.buttons) {
      renderedButtons.add(Button(
          width: button['width'],
          height: button['height'],
          color: button['color'],
          onPressed: () => onPressedHandler(button),
          child: button['widget'],
          active: widget.toggle ? button['key'] == _activeButtonKey : false));
      renderedButtons.add(const Padding(
        padding: EdgeInsets.only(right: 2),
      ));
    }

    return renderedButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [...renderButtons()],
    );
  }
}
