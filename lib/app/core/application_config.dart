import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:unichat/app/core/helpers/environments.dart';

import '../../firebase_options.dart';

class ApplicationConfig {
  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureFirebase();
    await Environments.loadEnvs();
  }

  _configureFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
