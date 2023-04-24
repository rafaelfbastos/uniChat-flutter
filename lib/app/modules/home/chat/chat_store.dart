// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/models/chat_menssage_model.dart';

import '../../../models/user_model.dart';

part 'chat_store.g.dart';

class ChatStore = ChatStoreBase with _$ChatStore;

abstract class ChatStoreBase with Store {
  final AuthStore _authStore;
  final FirebaseFirestore _firestore;

  @observable
  var mensages = <ChatMenssageModel>{}.asObservable();

  ChatStoreBase({
    required AuthStore authStore,
    required FirebaseFirestore firestore,
  })  : _authStore = authStore,
        _firestore = firestore {
    startStream();
  }

  @action
  startStream() {
    final Timestamp limiteInferior =
        Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 7)));

    _firestore
        .collection("chat-room")
        .doc(_authStore.userModel?.chatOpen)
        .collection("messages")
        .where("timestamp", isGreaterThanOrEqualTo: limiteInferior)
        .orderBy("timestamp")
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        mensages.add(ChatMenssageModel.fromMap(doc.data()));
      }
    });
  }

  @computed
  int get lastIndex => mensages.length;

  String get chatName => _authStore.userModel!.chatOpen;

  exitChat() {
    _authStore.updateUserChat("");
  }

  sendMessage(String text) async {
    final message = ChatMenssageModel(
        text: text, user: _authStore.userModel!, timestamp: Timestamp.now());

    await _firestore
        .collection("chat-room")
        .doc(_authStore.userModel?.chatOpen)
        .collection("messages")
        .add(message.toMap());
  }

  UserModel get user => _authStore.userModel!;
}
