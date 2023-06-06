import 'package:firebase_remote_config/firebase_remote_config.dart';

class Environments {
  Environments._();

  static String? stringParam(String paramName) {
    return FirebaseRemoteConfig.instance.getString(paramName);
  }

  static bool? boolParam(String paramName) {
    return FirebaseRemoteConfig.instance.getBool(paramName);
  }

  static double? doubleParam(String paramName) {
    return FirebaseRemoteConfig.instance.getDouble(paramName);
  }

  static loadEnvs() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
   await remoteConfig.setDefaults(const {
    "censor": true,
    "center_latitude": -12.937362312338534,
    "center_longitude": -38.40969907487264,
    "geo_block": true,
});

    await remoteConfig.fetchAndActivate();
  }
}
