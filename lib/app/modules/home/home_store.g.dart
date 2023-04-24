// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$geoBlockAtom =
      Atom(name: 'HomeStoreBase.geoBlock', context: context);

  @override
  bool get geoBlock {
    _$geoBlockAtom.reportRead();
    return super.geoBlock;
  }

  @override
  set geoBlock(bool value) {
    _$geoBlockAtom.reportWrite(value, super.geoBlock, () {
      super.geoBlock = value;
    });
  }

  late final _$mensagesAtom =
      Atom(name: 'HomeStoreBase.mensages', context: context);

  @override
  ObservableSet<ChatRoomModel> get mensages {
    _$mensagesAtom.reportRead();
    return super.mensages;
  }

  @override
  set mensages(ObservableSet<ChatRoomModel> value) {
    _$mensagesAtom.reportWrite(value, super.mensages, () {
      super.mensages = value;
    });
  }

  late final _$loadGeoBlockAsyncAction =
      AsyncAction('HomeStoreBase.loadGeoBlock', context: context);

  @override
  Future loadGeoBlock() {
    return _$loadGeoBlockAsyncAction.run(() => super.loadGeoBlock());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic startStream() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.startStream');
    try {
      return super.startStream();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
geoBlock: ${geoBlock},
mensages: ${mensages}
    ''';
  }
}
