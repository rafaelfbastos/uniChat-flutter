// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unichat/app/models/user_model.dart';

import 'package:unichat/app/repositories/user_repository_impl.dart';
import 'package:unichat/app/services/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepositoryImpl _repository;

  UserServiceImpl({
    required UserRepositoryImpl repository,
  }) : _repository = repository;

  @override
  Future<void> forgotPassword(String email) =>
      _repository.forgotPassword(email);

  @override
  Future<User?> login(String email, String password) =>
      _repository.login(email, password);

  @override
  Future<void> logout() => _repository.logout();

  @override
  Future<User?> register(String email, String password) =>
      _repository.register(email, password);

  @override
  Future<UserModel?> loadUser(String email) => _repository.loadUser(email);

  @override
  Future<void> saveUser(UserModel user) => _repository.saveUser(user);

  @override
  Future<void> userUpdateUs(UserModel user, Map<String, dynamic> map) =>
      _repository.userUpdateUs(user, map);
}
