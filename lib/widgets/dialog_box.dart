// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:to_do_app/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlueAccent,
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: "Add a New Task", border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(onPressed: onSave, text: "Save"),
              const SizedBox(width: 8),
              MyButton(
                onPressed: onCancel,
                text: "Cancel",
              ),
            ],
          )
        ]),
      ),
    );
  }
}
