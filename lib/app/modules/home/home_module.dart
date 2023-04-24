import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/modules/home/chat/chat_page.dart';
import 'package:unichat/app/modules/home/chat/chat_store.dart';
import 'package:unichat/app/modules/home/home_page.dart';
import 'package:unichat/app/modules/home/home_store.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatStore(authStore: i(), firestore: i())),
        Bind((i) => HomeStore(authStore: i(), firestore: i(), userService: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/home', child: (context, args) => const HomePage()),
        ChildRoute('/chat', child: (context, args) => const ChatPage()),
      ];
}
