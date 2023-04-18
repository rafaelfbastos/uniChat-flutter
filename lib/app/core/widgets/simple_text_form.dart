import 'package:flutter/material.dart';

class SimpleTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;

  const SimpleTextForm(
      {Key? key, required this.controller, required this.label, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ,
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}
