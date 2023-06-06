import 'package:flutter_modular/flutter_modular.dart';
import 'package:unichat/app/modules/home/chat/chat_page.dart';
import 'package:unichat/app/modules/home/chat/chat_store.dart';
import 'package:unichat/app/modules/home/dms/d_m_pages.dart';
import 'package:unichat/app/modules/home/dms/d_m_store.dart';
import 'package:unichat/app/modules/home/home_page.dart';
import 'package:unichat/app/modules/home/home_store.dart';
import 'package:unichat/app/modules/home/private-chat/private_chat_page.dart';
import 'package:unichat/app/modules/home/private-chat/private_chat_store.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatStore(authStore: i(), firestore: i())),
        Bind((i) => HomeStore(authStore: i(), firestore: i(), userService: i())),
        Bind((i) => PrivateChatStore(firestore: i(),authStore: i())),
        Bind((i) => DMStore(firestore: i(), authStore: i(), userService: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/home', child: (context, args) => const HomePage()),
        ChildRoute('/chat', child: (context, args) => const ChatPage()),
        ChildRoute('/chat-private', child: (context, args) =>  PrivateChatPage(users: args.data,store: context.read(),)),
        ChildRoute('/dm', child: (contex,args)=> DMPages(store: contex.read(),))
      ];
}
