import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialog extends StatefulWidget {
  final TextEditingController controller;
  final onPressed;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatter;

  const CustomDialog(
      {Key? key,
      required this.controller,
      required this.onPressed,
      required this.title,
      this.hintText = '',
      this.formatter,
      this.keyboardType = TextInputType.number})
      : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: widget.formatter ?? [],
        decoration: InputDecoration(hintText: widget.hintText),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: const Text('OK'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            widget.onPressed();
          },
        ),
      ],
    );
  }
}
