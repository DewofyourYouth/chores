import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/chores/chore_card.dart';
import '../components/kids/kid_button.dart';

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
        child: ListView(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 15.0),
              child: Center(
                child: Text(
                  "Chores for ${DateFormat("EEEE, MMM d").format(now)}:",
                  style: const TextStyle(
                    fontFamily: "RobotoSlab",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ...chores.map((c) => Container(
                color: Colors.blue,
                child: Center(
                  child: ChoreCard(chore: c),
                )))
          ],
        ),
      ),
    );
  }
}
//

