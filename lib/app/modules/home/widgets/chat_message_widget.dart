import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:unichat/app/core/helpers/environments.dart';
import 'package:unichat/app/core/helpers/global_const.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/models/chat_menssage_model.dart';
import 'package:unichat/app/models/user_model.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMenssageModel message;
  final UserModel user;

  const ChatMessageWidget({Key? key, required this.message, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final send = (message.user == user);
    final filter = ProfanityFilter.filterAdditionally(GlobalConst.censorWords);

    _showProfile(UserModel u) {
      AwesomeDialog(
        context: context,
        customHeader: RandomAvatar(u.avatar),
        animType: AnimType.rightSlide,
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

    return (send)
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ChatBubble(
                    clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 10),
                    backGroundColor: context.primaryColor,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        (Environments.boolParam("censor")!)
                            ? filter.censor(message.text)
                            : message.text,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showProfile(user),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.10,
                      ),
                      child: Column(
                        children: [
                          RandomAvatar(message.user.avatar,
                              width: MediaQuery.of(context).size.width * 0.10),
                          Text(
                            message.user.nickName,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _showProfile(message.user),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.10,
                      ),
                      child: Column(
                        children: [
                          RandomAvatar(message.user.avatar,
                              width: MediaQuery.of(context).size.width * 0.10),
                          Text(
                            message.user.nickName,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                  ChatBubble(
                    clipper:
                        ChatBubbleClipper1(type: BubbleType.receiverBubble),
                    backGroundColor: const Color(0xffE7E7ED),
                    margin: const EdgeInsets.only(top: 10),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        (Environments.boolParam("censor")!)
                            ? filter.censor(message.text)
                            : message.text,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
