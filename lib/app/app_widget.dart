import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/core/ui/ui_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute("/auth/");
    Modular.setObservers([Asuka.asukaHeroController]);

    return MaterialApp.router(
      title: UiConfig.title,
      builder: Asuka.builder,
      theme: UiConfig.theme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
