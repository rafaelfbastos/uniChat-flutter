import 'package:flutter/material.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';

class SimpleTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const SimpleTextForm(
      {Key? key,
      required this.controller,
      required this.label,
      this.validator,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: context.primaryColor),
      validator: validator,
      controller: controller,
      cursorColor: context.primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        isDense: true,
        fillColor: const Color(0xffDAD1D1).withAlpha(50),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.primaryColor),
        ),
      ),
    );
  }
}
