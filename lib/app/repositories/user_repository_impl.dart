// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unichat/app/models/user_model.dart';

import 'package:unichat/app/repositories/user_repository.dart';

import '../core/exceptions/auth_exception.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  UserRepositoryImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(message: "Usuário não encontrado");
      } else if (e.code == 'wrong-password') {
        throw AuthException(message: "Senha inválida");
      }
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginTypes.contains("password")) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else {
        throw AuthException(message: "E-mail não cadastrado:");
      }
    } on AuthException catch (e) {
      throw AuthException(message: "E-mail não cadastrado:");
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "invalid-email") {
          throw AuthException(message: "E-mail Inválido:");
        } else {
          throw AuthException(message: e.message);
        }
      }
    }
  }

  @override
  Future<void> logout() async {
    _firebaseAuth.signOut();
  }

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = UserModel(email: email);
      await saveUser(user);
      return userCredencial.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains("password")) {
          throw AuthException(message: "E-mail ja casdastrado:");
        }
      } else {
        AuthException(message: "Erro ao cadastrar:");
      }
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _firestore.collection("users").doc(user.email).set(user.toMap());
  }

  @override
  Future<UserModel?> loadUser(String email) async {
    final doc = await _firestore.collection("users").doc(email).get();
    final data = doc.data();
    return (data != null) ? UserModel.fromMap(data) : null;
  }
}
