import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/modules/home/widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final toDispose = <ReactionDisposer>[];

  @override
  void initState() {
    final userModelReaction =
        reaction((p0) => context.read<AuthStore>().userModel, (userModel) {
      if (userModel?.nickName == "") {
        Modular.to.pushReplacementNamed("/auth/complete-profile",
            arguments: userModel);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<AuthStore>().loadUserModel();
    });

    toDispose.add(userModelReaction);

    super.initState();
  }

  @override
  void dispose() {
    toDispose.map((e) => e);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text(
          'Bem Vindo ao UniChat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text("logout"),
            onPressed: () {
              context.read<AuthStore>().logout();
            },
          ),
          RandomAvatar('c73aa52ad348d7e59a', height: 50, width: 50),
          Text("${context.read<AuthStore>().userModel?.nickName}")
        ],
      ),
    );
  }
}
