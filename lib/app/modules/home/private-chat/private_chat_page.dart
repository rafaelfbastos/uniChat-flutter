import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/models/user_model.dart';
import 'package:unichat/app/modules/home/private-chat/private_chat_store.dart';

import '../widgets/chat_message_widget.dart';

class PrivateChatPage extends StatefulWidget {
  final List<UserModel> users;
  final PrivateChatStore _store;

  const PrivateChatPage(
      {Key? key, required this.users, required PrivateChatStore store})
      : _store = store,
        super(key: key);

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final mensageEC = TextEditingController();
  final _scrollController = ScrollController();
  final toDispose = <ReactionDisposer>[];

  @override
  void initState() {
    print(widget.users);
    widget._store.loadUser(widget.users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.users[1].nickName),
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
                      children: widget._store.mensages
                          .map((e) => ChatMessageWidget(
                              message: e, user: widget.users[0]))
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
                          widget._store.sendMessage(mensageEC.text);
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
