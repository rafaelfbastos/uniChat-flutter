import 'package:firebase_auth/firebase_auth.dart';
import 'package:unichat/app/models/user_model.dart';

abstract class UserRepository {
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> logout();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> loadUser(String email);
  Future<void> userUpdateUs(UserModel user, Map<String, dynamic> map);
}
