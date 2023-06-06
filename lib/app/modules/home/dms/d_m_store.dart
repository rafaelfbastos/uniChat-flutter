import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/models/chat_private_model.dart';
import 'package:unichat/app/models/user_model.dart';
import 'package:unichat/app/services/user_service.dart';
part 'd_m_store.g.dart';

class DMStore = DMStoreBase with _$DMStore;

abstract class DMStoreBase with Store {
  final FirebaseFirestore _firestore;
  final AuthStore _authStore;
  final UserService _userService;

  UserModel? get user => _authStore.userModel;
  
  
  @observable
  var privateChats = <ChatPrivateModel>{}.asObservable();

  @observable
  var usersModel = <UserModel>{}.asObservable();

  DMStoreBase(
      {required FirebaseFirestore firestore, required AuthStore authStore, required UserService userService})
      : _firestore = firestore,
        _authStore = authStore,
        _userService=userService {
    final user = _authStore.userModel;
    
    
    _firestore
        .collection("chat-private")
        .where("users", arrayContains: user?.email)
        .snapshots()
        .listen((event) {
          for (var doc in event.docs) {
        
        final chat = ChatPrivateModel.fromMap(doc.data());
        privateChats.add(chat);

        final email = chat.users.firstWhere((element) => element!=user!.email);
        _userService.loadUser(email).then((value) => usersModel.add(value!));

      }
        });
  }

  UserModel otherUser(ChatPrivateModel chatmodel){

    String email = chatmodel.users.firstWhere((element) => element!=user?.email);

    return usersModel.firstWhere((value) => value.email==email);
  }



}
