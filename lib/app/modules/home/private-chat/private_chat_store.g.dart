// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PrivateChatStore on PrivateChatStoreBase, Store {
  late final _$mensagesAtom =
      Atom(name: 'PrivateChatStoreBase.mensages', context: context);

  @override
  ObservableSet<ChatMenssageModel> get mensages {
    _$mensagesAtom.reportRead();
    return super.mensages;
  }

  @override
  set mensages(ObservableSet<ChatMenssageModel> value) {
    _$mensagesAtom.reportWrite(value, super.mensages, () {
      super.mensages = value;
    });
  }

  @override
  String toString() {
    return '''
mensages: ${mensages}
    ''';
  }
}
