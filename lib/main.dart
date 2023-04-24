import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/app_module.dart';
import 'package:unichat/app/app_widget.dart';
import 'package:unichat/app/core/application_config.dart';

Future<void> main() async {
  await ApplicationConfig().configureApp();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
