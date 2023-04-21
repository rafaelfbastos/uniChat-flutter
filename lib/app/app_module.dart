import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/modules/auth/auth_module.dart';
import 'package:unichat/app/modules/home/home_module.dart';
import 'package:unichat/app/repositories/user_repository_impl.dart';
import 'package:unichat/app/services/user_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => FirebaseAuth.instance),
        Bind.lazySingleton((i) => FirebaseFirestore.instance),
        Bind((i) => UserRepositoryImpl(firebaseAuth: i(), firestore: i())),
        Bind((i) => UserServiceImpl(repository: i())),
        Bind((i) => AuthStore(firebaseAuth: i(), userService: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/auth", module: AuthModule()),
        ModuleRoute("/home", module: HomeModule()),
      ];
}
