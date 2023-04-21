import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashPage extends StatefulWidget {
  final AuthStore _authStore;

  const SplashPage({Key? key, required AuthStore authStore})
      : _authStore = authStore,
        super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    reaction((_) => widget._authStore.currentUser, (user) {
      if (user != null) {
        Modular.to.pushNamedAndRemoveUntil("/home", (p0) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil("/auth/login", (p0) => false);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        widget._authStore.loadUsers();
        if (widget._authStore.currentUser != null) {
          Modular.to.pushNamedAndRemoveUntil("/home", (p0) => false);
        } else {
          Modular.to.pushNamedAndRemoveUntil("/auth/login", (p0) => false);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/img/logo.png"),
            const SizedBox(height: 10),
            DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: 'Bobbers',
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText('UniChat',
                        speed: const Duration(milliseconds: 100)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
