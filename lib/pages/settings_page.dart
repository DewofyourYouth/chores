import 'package:flutter/material.dart';

import '../components/chores/new_chore.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            NewChore(),
          ],
        ));
  }
}
