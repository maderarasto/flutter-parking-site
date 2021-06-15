import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final Text title;
  final Text content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const Alert(
      {Key? key,
      this.title = const Text(''),
      this.content = const Text(''),
      required this.onConfirm,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onCancelPressed() {
      onCancel!();
      Navigator.pop(context);
    }

    void onConfirmPressed() {
      onConfirm!();
      Navigator.pop(context);
    }

    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: onCancel != null ? onCancelPressed : onCancel,
        ),
        TextButton(
          child: const Text('Confirm'),
          onPressed: onConfirm != null ? onConfirmPressed : onConfirm,
        ),
      ],
    );
  }
}
