import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/chores/chore_card.dart';
import '../components/kids/kid_card.dart';
import '../constants.dart';

class KidsChoresPage extends StatelessWidget {
  final Data data;
  const KidsChoresPage({Key? key, required this.data}) : super(key: key);

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
            ...daiyChores.map((c) => Container(
                color: Colors.blue,
                child: Center(
                  child: ChoreCard(
                    chore: c,
                    name: name,
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
//
