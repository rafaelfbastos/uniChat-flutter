import 'package:flutter/material.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';

class UnichatLogo extends StatelessWidget {
  const UnichatLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 130,
          child: Image.asset("assets/img/logo.png"),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "UniChat",
          style: TextStyle(
              color: context.primaryColor,
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
