import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/modules/auth/login/login_page.dart';
import 'package:unichat/app/modules/auth/splash_page.dart';

class AuthModule extends Module {

   @override
   List<Bind> get binds => [];

   @override
   List<ModularRoute> get routes => [
      ChildRoute('/', child: (context, args) => const SplashPage()),
      ChildRoute('/login', child: (context, args) => const LoginPage()),
   ];

}