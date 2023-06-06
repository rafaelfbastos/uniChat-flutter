import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/models/user_model.dart';

class DMWidget extends StatelessWidget {
  final UserModel user;
  final UserModel currentUser;
 

  const DMWidget({ Key? key, required this.user,  required this.currentUser }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
         child: ListTile(
          leading: RandomAvatar(user.avatar,width: 45),
          title: Text(user.nickName, style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.primaryColor
          ),),
          subtitle: Text(user.curso),
          onTap: (){
             Navigator.of(context).popAndPushNamed("/chat-private",arguments: [currentUser,user]);
          },
         ),
       );
  }
}