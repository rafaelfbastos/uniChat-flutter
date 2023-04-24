import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/models/chat_room_model.dart';
import 'package:unichat/app/models/user_model.dart';
import 'package:unichat/app/core/location/location.dart';

import '../../core/auth/auth_store.dart';
import '../../services/user_service_impl.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final AuthStore _authStore;
  final FirebaseFirestore _firestore;
  final UserServiceImpl _userService;

  @observable
  bool geoBlock = false;

  @observable
  var mensages = <ChatRoomModel>{}.asObservable();

  HomeStoreBase({
    required AuthStore authStore,
    required FirebaseFirestore firestore,
    required UserServiceImpl userService,
  })  : _authStore = authStore,
        _firestore = firestore,
        _userService = userService {
    startStream();
  }

  @action
  startStream() {
    _firestore
        .collection("chat-room")
        .orderBy("create")
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        mensages.add(ChatRoomModel.fromMap(doc.data()));
      }
    });
  }

  setUserChat(String chat) {
    _authStore.updateUserChat(chat);
  }

  addChat(ChatRoomModel chat) async {
    await _firestore.collection("chat-room").doc(chat.name).set(chat.toMap());
  }

  UserModel? get userModel => _authStore.userModel;

  @action
  loadGeoBlock() async {
    geoBlock = await Location.geoBlock();
  }

  timer() {
    loadGeoBlock();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      loadGeoBlock();
    });
  }
}
