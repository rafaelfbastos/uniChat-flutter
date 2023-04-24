import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/models/user_model.dart';

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

  @observable
  UserModel? userModel;

  Future<void> logout() async {
    _userService.logout();
  }

  @action
  loadUser() {
    currentUser = _firebaseAuth.currentUser;
  }

  @action
  loadUserModel() async {
    if (currentUser != null) {
      userModel = await _userService.loadUser(currentUser!.email!);
    }
  }

  @action
  updateUserChat(String chat) {
    userModel = userModel?.copyWith(chatOpen: chat);
    _userService.userUpdateUs(userModel!, {'chatOpen': chat});
  }

  loadUsers() {
    loadUser();
    loadUserModel();
  }
}
