import 'package:flutter/material.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';

class PasswordTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const PasswordTextForm(
      {Key? key,
      required this.controller,
      required this.label,
      this.hintText,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obscureVN = ValueNotifier<bool>(true);

    return ValueListenableBuilder(
      valueListenable: obscureVN,
      builder: (context, value, child) => TextFormField(
        style: TextStyle(color: context.primaryColor),
        obscureText: value,
        validator: validator,
        controller: controller,
        cursorColor: context.primaryColor,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon((value) ? Icons.visibility : Icons.visibility_off),
            onPressed: () => obscureVN.value = !value,
          ),
          suffixIconColor: context.primaryColor,
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
      ),
    );
  }
}
