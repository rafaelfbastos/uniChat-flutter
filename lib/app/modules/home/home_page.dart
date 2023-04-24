import 'package:awesome_icons/awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:unichat/app/core/widgets/simple_text_form.dart';
import 'package:unichat/app/models/chat_room_model.dart';
import 'package:unichat/app/modules/home/home_store.dart';
import 'package:unichat/app/modules/home/widgets/home_drawer.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final toDispose = <ReactionDisposer>[];
  final nomeEC = TextEditingController();
  final temaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    reaction((p0) => controller.userModel, (userModel) {
      if (userModel?.nickName == "") {
        Modular.to.pushNamedAndRemoveUntil(
            "/auth/complete-profile", (_) => false,
            arguments: userModel);
      }
      if (userModel?.chatOpen != "") {
        Modular.to.pushNamedAndRemoveUntil("/chat", (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil("/home", (_) => false);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<AuthStore>().loadUserModel();
      if (controller.userModel?.nickName == "") {
        Modular.to.pushNamedAndRemoveUntil(
            "/auth/complete-profile", (_) => false,
            arguments: controller.userModel);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    nomeEC.dispose();
    temaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _newChat() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Criar nova sala",
                  style: TextStyle(color: context.primaryColor),
                ),
                content: Form(
                    key: formKey,
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SimpleTextForm(
                            controller: nomeEC,
                            label: "Nome da Sala",
                            validator: Validatorless.required("Obrigatório"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SimpleTextForm(
                            controller: temaEC,
                            label: "Tema",
                            validator: Validatorless.required("Obrigatório"),
                          ),
                        ],
                      ),
                    )),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final formValid =
                          formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final chat = ChatRoomModel(
                            name: nomeEC.text,
                            tema: temaEC.text,
                            create: Timestamp.now());
                        controller.addChat(chat);
                        nomeEC.text = "";
                        temaEC.text = "";
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.primaryColor),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Criar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
                actionsAlignment: MainAxisAlignment.center,
              ));
    }

    return Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => _newChat(),
                icon: const Icon(FontAwesomeIcons.plus))
          ],
          title: const Text(
            'Bem Vindo ao UniChat',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Observer(
                builder: (context) => ListView(
                      children: controller.mensages
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                    onTap: () => controller.setUserChat(e.name),
                                    tileColor:
                                        context.primaryColor.withAlpha(40),
                                    title: Text(
                                      "Sala: ${e.name}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tema: ${e.tema}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Criado a ${e.daysElapsed} dias",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ))
                          .toList(),
                    ))));
  }
}
