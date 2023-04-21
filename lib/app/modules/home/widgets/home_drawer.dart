import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:unichat/app/core/auth/auth_store.dart';
import 'package:unichat/app/core/ui/theme_extension.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final authStore = context.read<AuthStore>();

    return Drawer(
      child: ListView(children: [
        Observer(
          builder: (_) => DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(30)),
            child: Row(
              children: [
                RandomAvatar(authStore.userModel!.avatar, width: 80),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    authStore.userModel!.nickName,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: context.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () => Modular.to.pushNamed("/auth/complete-profile",
              arguments: authStore.userModel),
          leading: const Icon(Icons.edit),
          title: const Text(
            "editar Perfil",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          onTap: () => authStore.logout(),
          leading: const Icon(Icons.logout_rounded),
          title: const Text(
            "logout",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}
