// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/models/chat_private_model.dart';
import 'package:unichat/app/models/user_model.dart';

import '../../../models/chat_menssage_model.dart';

part 'private_chat_store.g.dart';

class PrivateChatStore = PrivateChatStoreBase with _$PrivateChatStore;

abstract class PrivateChatStoreBase with Store {
  String? id;
  final AuthStore _authStore;

  final FirebaseFirestore _firestore;
  List<UserModel>? users;

  PrivateChatStoreBase({
    this.users,
    required AuthStore authStore,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _authStore = authStore;

  @observable
  var mensages = <ChatMenssageModel>{}.asObservable();

  _start() async {
    mensages.clear();
    final doc = _firestore
        .collection("chat-private")
        .where('users', arrayContains: users?[0].email);

    final snap = await doc.get();

    if (snap.size == 0) {
      final chatPM =
          ChatPrivateModel(users: users!.map((e) => e.email).toList());
      final data =
          await _firestore.collection("chat-private").add(chatPM.toMap());
      id = data.id;
    } else {
      for (var doc in snap.docs) {
        final data = doc.data()['users'] as List<dynamic>;
        final email = data.map((e) => e.toString()).toList();

        if (email.contains(users?[1].email)) {
          id = doc.id;
          print(id);
        }
      }

      if (id == null) {
        final chatPM =
            ChatPrivateModel(users: users!.map((e) => e.email).toList());
        final data =
            await _firestore.collection("chat-private").add(chatPM.toMap());
        id = data.id;
      }
      final Timestamp limiteInferior =
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 7)));

      _firestore
          .collection("chat-private")
          .doc(id)
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
  }

  sendMessage(String text) async {
    final message =
        ChatMenssageModel(text: text, user: user!, timestamp: Timestamp.now());
    await _firestore
        .collection("chat-private")
        .doc(id)
        .collection("messages")
        .add(message.toMap());
  }

  UserModel? get user => _authStore.userModel;

  loadUser(List<UserModel> users) {
    this.users = users;
    _start();
  }
}
