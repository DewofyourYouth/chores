import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'kid_button.dart';

class KidsChoresPage extends StatelessWidget {
  final Data data;
  KidsChoresPage({Key? key, required this.data}) : super(key: key);

  // final String name;
  final List<String> chores = [
    "Breakfast: clear dishes and utensils",
    "Clearing dishes after meals",
    "Put away coats, tik and shoes",
    "Clear toys"
  ];

  @override
  Widget build(BuildContext context) {
    String name = data.name;
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text("$name Chores Page"),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Center(
          child: Column(
        children: [
          Text("Chores for ${DateFormat.yMMMd().format(now)}:"),
          ChoreList(chores: chores),
        ],
      )),
    );
  }
}

class ChoreList extends StatelessWidget {
  const ChoreList({
    Key? key,
    required this.chores,
  }) : super(key: key);

  final List<String> chores;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ...chores.map((c) => Container(
              padding: const EdgeInsets.all(8),
              height: 50,
              color: Colors.amber,
              child: Center(
                child: Text(c),
              )))
        ],
      ),
    );
  }
}
