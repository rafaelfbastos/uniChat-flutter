import 'package:flutter/material.dart';
import 'package:unichat/app/core/widgets/password_text_form.dart';
import 'package:unichat/app/core/widgets/simple_text_form.dart';
import 'package:unichat/app/core/widgets/unichat_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            const UnichatLogo(),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Acessar:",
                style: TextStyle(
                    color: Color(0xff797979),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SimpleTextForm(controller: emailEC, label: "e-mail"),
            const SizedBox(
              height: 20,
            ),
            PasswordTextForm(controller: passwordEC, label: "senha")
          ],
        ),
      ),
    );
  }
}
