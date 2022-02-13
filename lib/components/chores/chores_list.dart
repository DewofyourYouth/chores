import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/models/chore_day.dart';
import 'chore_card.dart';

class ChoresList extends StatelessWidget {
  const ChoresList({
    Key? key,
    required this.now,
    required this.chores,
    required this.name,
  }) : super(key: key);

  final DateTime now;
  final ChoreDay chores;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        ...chores.chores.map((c) => Container(
            color: Colors.blue,
            child: Center(
              child: ChoreCard(
                chores: chores,
                chore: c.chore,
                name: name,
                done: c.done,
              ),
            )))
      ],
    );
  }
}
