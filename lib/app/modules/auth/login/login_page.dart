import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/core/widgets/password_text_form.dart';
import 'package:unichat/app/core/widgets/simple_text_form.dart';
import 'package:unichat/app/core/widgets/unichat_logo.dart';
import 'package:unichat/app/modules/auth/login/login_store.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          const UnichatLogo(),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Acessar:",
                    style: TextStyle(
                        color: Color(0xff797979),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SimpleTextForm(
                    controller: emailEC,
                    label: "e-mail",
                    validator: Validatorless.multiple([
                      Validatorless.required("digite e-mail"),
                      Validatorless.email("digite e-mail válido")
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PasswordTextForm(
                    controller: passwordEC,
                    label: "senha",
                    validator: Validatorless.multiple(
                        [Validatorless.required("digite a senha")]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: (() {
                    Modular.to.pushNamed("/auth/reset-password");
                  }),
                  child: const Text("Esqueceu a senha?")),
              ElevatedButton(
                onPressed: (() async {
                  final formValid = formKey.currentState?.validate() ?? false;
                  if (formValid) {
                    controller.logar(emailEC.text, passwordEC.text);
                    FocusScope.of(context).unfocus();
                  }
                }),
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffE42E2E).withAlpha(50),
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: const Color(0xffE42E2E).withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Não tem conta?"),
                  TextButton(
                      onPressed: (() {
                        Navigator.of(context).pushNamed("/auth/register");
                      }),
                      child: const Text("Cadastre-se"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
