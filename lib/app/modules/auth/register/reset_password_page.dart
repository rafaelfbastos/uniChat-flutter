import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/modules/auth/login/login_store.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/widgets/simple_text_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends ModularState<ResetPasswordPage, LoginStore> {
  final emailEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (() => Navigator.pop(context)),
          icon: ClipOval(
              child: Container(
            padding: const EdgeInsets.all(8),
            color: context.primaryColor.withAlpha(10),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: context.primaryColor,
            ),
          )),
        ),
        title: Text(
          'Resetar senha',
          style: TextStyle(
              color: context.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Informe o e-mail cadastrado:",
            style: TextStyle(
                color: Color(0xff797979),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SimpleTextForm(
                        controller: emailEC,
                        label: "e-mail",
                        validator: Validatorless.multiple([
                          Validatorless.required("digite e-mail"),
                          Validatorless.email("digite e-mail válido")
                        ])),
                    const SizedBox(height: 20),
                  ],
                ),
              )),
          ElevatedButton(
            onPressed: (() {
              final formValid = formKey.currentState?.validate() ?? false;
              if (formValid) {
                controller.forgotPassword(emailEC.text);
                FocusScope.of(context).unfocus();
              }
            }),
            style:
                ElevatedButton.styleFrom(backgroundColor: context.primaryColor),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Enviar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
