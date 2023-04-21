import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/widgets/loader.dart';
import 'package:unichat/app/core/widgets/messages.dart';
import 'package:unichat/app/models/user_model.dart';
import 'package:unichat/app/services/user_service_impl.dart';
import '../../../core/exceptions/auth_exception.dart';
part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final UserServiceImpl _userService;

  User? user;

  LoginStoreBase({required UserServiceImpl userService})
      : _userService = userService;

  logar(String email, String password) async {
    Loader.show();
    try {
      user = await _userService.login(email, password);
      Loader.hide();
    } on Exception catch (e) {
      if (e is AuthException) {
        Messages.alert(e.message ?? "Erro");
      }
    } finally {
      Loader.hide();
    }
  }

  register(String email, String password) async {
    Loader.show();
    try {
      user = await _userService.register(email, password);
      Loader.hide();
    } on Exception catch (e) {
      if (e is AuthException) {
        Messages.alert(e.message ?? "Erro");
      }
    } finally {
      Loader.hide();
    }
  }

  forgotPassword(String email) async {
    Loader.show();
    try {
      await _userService.forgotPassword(email);
      Loader.hide();
      Messages.sucess("Reset password enviado para $email");
    } on Exception catch (e) {
      if (e is AuthException) {
        Messages.alert(e.message ?? "Erro");
      }
    } finally {
      Loader.hide();
    }
  }

  completeProfile(UserModel user) async {
    Loader.show();
    await _userService.saveUser(user);
    Loader.hide();
  }
}
