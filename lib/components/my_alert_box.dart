import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final GlobalKey<FormState> keyForm;

  const MyAlertBox(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onSave,
      required this.onCancel,
      required this.keyForm});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        content: TextFormField(
          validator: (value) => value!.isEmpty ? "diisi dulu ya" : null,
          controller: controller,
          style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: onSave,
            color: Colors.black,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: onCancel,
            color: Colors.black,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
