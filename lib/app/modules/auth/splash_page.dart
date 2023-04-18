import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        
        Future.delayed(Duration(milliseconds: 3000), () {
            Modular.to.pushNamedAndRemoveUntil("/auth/login", (p0) => false);
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
                    TyperAnimatedText('UniChat',speed: const Duration(milliseconds: 100)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
