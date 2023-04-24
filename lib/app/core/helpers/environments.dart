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
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    await remoteConfig.fetchAndActivate();
  }
}
