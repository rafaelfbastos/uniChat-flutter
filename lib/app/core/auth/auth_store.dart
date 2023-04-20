import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

import '../../services/user_service.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthStoreBase({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService {
    _firebaseAuth.authStateChanges().listen((user) {
      currentUser = user;
    });
  }

  @observable
  User? currentUser;

  Future<void> logout() async {
    _userService.logout();
    loadUser();
  }

  @action
  loadUser() {
    currentUser = _firebaseAuth.currentUser;
  }
}
