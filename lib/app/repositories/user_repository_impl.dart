import 'package:firebase_auth/firebase_auth.dart';
import 'package:unichat/app/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl(this._firebaseAuth);

  @override
  Future<User?> login(String email, String password) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }
}
