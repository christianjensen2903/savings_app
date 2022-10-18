import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSavingsDialog extends StatefulWidget {
  final TextEditingController controller;
  final onPressed;

  const AddSavingsDialog(
      {Key? key, required this.controller, required this.onPressed})
      : super(key: key);

  @override
  State<AddSavingsDialog> createState() => _AddSavingsDialogState();
}

class _AddSavingsDialogState extends State<AddSavingsDialog> {
  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How much did you save?'),
      content: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(hintText: "Enter Amount"),
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
          child: const Text('ADD'),
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
