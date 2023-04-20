import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/modules/auth/login/login_page.dart';
import 'package:unichat/app/modules/auth/login/login_store.dart';
import 'package:unichat/app/modules/auth/register/register_page.dart';
import 'package:unichat/app/modules/auth/register/reset_password_page.dart';
import 'package:unichat/app/modules/auth/splash_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => LoginStore(userService: i()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => SplashPage(
                  authStore: context.read(),
                )),
        ChildRoute('/login', child: (context, args) => const LoginPage()),
        ChildRoute('/register', child: (context, args) => const RegisterPage()),
        ChildRoute('/reset-password',
            child: (context, args) => const ResetPasswordPage()),
      ];
}
