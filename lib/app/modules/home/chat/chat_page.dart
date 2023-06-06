import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/modules/home/chat/chat_store.dart';
import 'package:unichat/app/modules/home/widgets/chat_message_widget.dart';

import '../../../models/user_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatStore> {
  final mensageEC = TextEditingController();
  final _scrollController = ScrollController();
  final toDispose = <ReactionDisposer>[];
  @override
  void initState() {
    reaction((_) => controller.lastIndex, (index) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.bounceOut);
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    mensageEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    _showProfile(UserModel u) {
      AwesomeDialog(
        context: context,
        customHeader: RandomAvatar(u.avatar),
        animType: AnimType.rightSlide,
        btnOkOnPress: (){
          if(u!=store.user){
            Navigator.of(context).popAndPushNamed("/chat-private",arguments: [store.user,u]);
          }
        },
        btnOkText: "Chat Privado",
        body: Column(children: [
          Text(
            u.nickName,
            style: TextStyle(
                color: context.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            u.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            u.curso,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ).show();
    }

    return Scaffold(
      drawer: Drawer(
          child: Observer(
        builder: (context) => Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration:
                    BoxDecoration(color: context.primaryColor.withAlpha(30)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Usuários',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
            ...store.users
                .map(
                  (e) => ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.solidCircle,
                      color: Colors.green,
                      size: 15,
                    ),
                    title: Text(
                      e.nickName,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: ()=> _showProfile(e),
                  ),
                )
                .toList()
          ],
        ),
      )),
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: (() {
              controller.exitChat();
            }),
            icon: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: context.primaryColor.withAlpha(10),
                child: Icon(
                  Icons.logout_outlined,
                  size: 20,
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
        ],
        title: Text(
          controller.chatName.toUpperCase(),
          style: TextStyle(
              color: context.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Observer(
        builder: (context) => Column(
          children: [
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(color: context.primaryColor.withAlpha(20)),
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: controller.mensages
                          .map((e) => ChatMessageWidget(
                              message: e, user: controller.user))
                          .toList(),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        constraints: const BoxConstraints(minHeight: 10),
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextField(
                          maxLines: 5,
                          minLines: 1,
                          cursorColor: context.primaryColor,
                          controller: mensageEC,
                          decoration: InputDecoration(
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: context.primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: context.primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: context.primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          controller.sendMessage(mensageEC.text);
                          mensageEC.text = "";
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: context.primaryColor,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
