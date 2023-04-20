import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/core/widgets/messages.dart';
import 'package:unichat/app/core/widgets/password_text_form.dart';
import 'package:unichat/app/core/widgets/simple_text_form.dart';
import 'package:unichat/app/core/widgets/unichat_logo.dart';
import 'package:unichat/app/modules/auth/login/login_store.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ModularState<RegisterPage, LoginStore> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final disposers = <ReactionDisposer>[];

  @override
  void initState() {
    final userReaction = reaction((_) => controller.user, (user) {
      if (user != null) {
        Messages.sucess("Cadastro realizado com sucesso");
        Modular.to.pop();
      }
    });

    disposers.add(userReaction);
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    confirmPasswordEC.dispose();
    disposers.map((e) => e);

    super.dispose();
  }

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
          'Cadastro',
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
          const UnichatLogo(),
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
                    PasswordTextForm(
                      controller: passwordEC,
                      label: "senha",
                      validator: Validatorless.multiple(
                          [Validatorless.required("digite a senha")]),
                    ),
                    const SizedBox(height: 20),
                    PasswordTextForm(
                      controller: confirmPasswordEC,
                      label: "confirmação de senha",
                      validator: Validatorless.multiple([
                        Validatorless.required("digite a senha"),
                        Validatorless.compare(
                            passwordEC, "As senhas não coincidem")
                      ]),
                    ),
                  ],
                ),
              )),
          ElevatedButton(
            onPressed: (() {
              final formValid = formKey.currentState?.validate() ?? false;
              if (formValid) {
                controller.register(emailEC.text, passwordEC.text);
                FocusScope.of(context).unfocus();
              }
            }),
            style:
                ElevatedButton.styleFrom(backgroundColor: context.primaryColor),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Cadastrar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
