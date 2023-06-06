// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'd_m_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DMStore on DMStoreBase, Store {
  late final _$privateChatsAtom =
      Atom(name: 'DMStoreBase.privateChats', context: context);

  @override
  ObservableSet<ChatPrivateModel> get privateChats {
    _$privateChatsAtom.reportRead();
    return super.privateChats;
  }

  @override
  set privateChats(ObservableSet<ChatPrivateModel> value) {
    _$privateChatsAtom.reportWrite(value, super.privateChats, () {
      super.privateChats = value;
    });
  }

  late final _$usersModelAtom =
      Atom(name: 'DMStoreBase.usersModel', context: context);

  @override
  ObservableSet<UserModel> get usersModel {
    _$usersModelAtom.reportRead();
    return super.usersModel;
  }

  @override
  set usersModel(ObservableSet<UserModel> value) {
    _$usersModelAtom.reportWrite(value, super.usersModel, () {
      super.usersModel = value;
    });
  }

  @override
  String toString() {
    return '''
privateChats: ${privateChats},
usersModel: ${usersModel}
    ''';
  }
}
