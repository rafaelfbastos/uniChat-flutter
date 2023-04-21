import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/core/helpers/avatar_const.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/core/widgets/simple_text_form.dart';
import 'package:unichat/app/models/user_model.dart';
import 'package:unichat/app/modules/auth/login/login_store.dart';
import 'package:validatorless/validatorless.dart';

class CompleteProfilePage extends StatefulWidget {
  final UserModel user;
  const CompleteProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState
    extends ModularState<CompleteProfilePage, LoginStore> {
  final emailEC = TextEditingController();
  final nicknameEC = TextEditingController();
  final nameEC = TextEditingController();
  final cursoEC = TextEditingController();
  final avatarVN =
      ValueNotifier<String>(AvatarConst.avatars[Random().nextInt(45)]);
  final formKey = GlobalKey<FormState>();
  bool compulsory = false;

  @override
  void initState() {
    compulsory = (widget.user.nickName.isEmpty);

    emailEC.text = widget.user.email;
    if (!compulsory) {
      nicknameEC.text = widget.user.nickName;
      nameEC.text = widget.user.name;
      cursoEC.text = widget.user.curso;
      avatarVN.value = widget.user.avatar;
    }
    super.initState();
  }

  _mudarAvatar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Escolha seu avatar:",
          style: TextStyle(color: context.primaryColor),
        ),
        content: SingleChildScrollView(
          child: Wrap(
            children: AvatarConst.avatars
                .map((e) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                          onTap: () {
                            avatarVN.value = e;
                            Navigator.of(context).pop();
                          },
                          child: RandomAvatar(e, height: 50, width: 50)),
                    ))
                .toList(),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              avatarVN.value = DateTime.now().toIso8601String();
              Navigator.of(context).pop();
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: context.primaryColor),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Aleatório",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: compulsory
            ? [
                IconButton(
                    onPressed: () => context.read<AuthStore>().logout(),
                    icon: Icon(
                      Icons.logout_outlined,
                      color: context.primaryColor,
                    ))
              ]
            : null,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: (!compulsory)
            ? IconButton(
                onPressed: (() => Navigator.pop(context)),
                icon: ClipOval(
                    child: Container(
                  padding: const EdgeInsets.all(8),
                  color: context.primaryColor.withAlpha(10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: context.primaryColor,
                  ),
                )),
              )
            : null,
        title: Text(
          'Perfil',
          style: TextStyle(
              color: context.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(children: [
                ValueListenableBuilder(
                  valueListenable: avatarVN,
                  builder: (context, avatar, child) {
                    return GestureDetector(
                      child: RandomAvatar(avatar),
                      onTap: () => _mudarAvatar(),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SimpleTextForm(
                  controller: emailEC,
                  label: "email",
                  readOnly: true,
                  enabled: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                SimpleTextForm(
                  controller: nicknameEC,
                  label: "nickname",
                  validator: Validatorless.required("obrigatório"),
                ),
                const SizedBox(
                  height: 10,
                ),
                SimpleTextForm(
                    controller: nameEC,
                    label: "nome",
                    validator: Validatorless.required("obrigatório")),
                const SizedBox(
                  height: 10,
                ),
                SimpleTextForm(
                    controller: cursoEC,
                    label: "curso",
                    validator: Validatorless.required("obrigatório")),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (() async {
                    final formValid = formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      final user = UserModel(
                          email: emailEC.text,
                          name: nameEC.text,
                          nickName: nicknameEC.text,
                          avatar: avatarVN.value,
                          curso: cursoEC.text);
                      FocusScope.of(context).unfocus();
                      await controller.completeProfile(user);
                      await Modular.get<AuthStore>().loadUserModel();
                      Modular.to.pushReplacementNamed("/home");
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.primaryColor),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Salvar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
