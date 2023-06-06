import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:unichat/app/modules/home/dms/d_m_store.dart';
import 'package:unichat/app/modules/home/widgets/d_m_widget.dart';

class DMPages extends StatefulWidget {
  final DMStore _store;

  const DMPages({Key? key, required DMStore store})
      : _store = store,
        super(key: key);

  @override
  State<DMPages> createState() => _DMPagesState();
}

class _DMPagesState extends State<DMPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DMS'),
      ),
      body: Observer(
        builder: (context) => ListView(
          children: [
            ...widget._store.privateChats.map((e) => DMWidget(user: widget._store.otherUser(e), currentUser: widget._store.user!)).toList()
          ],
        )
      ),
    );
  }
}
