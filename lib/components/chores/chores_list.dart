import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/models/chore_day.dart';
import 'chore_card.dart';

class ChoresList extends StatelessWidget {
  const ChoresList({
    Key? key,
    required this.date,
    required this.chores,
    required this.name,
  }) : super(key: key);

  final DateTime date;
  final ChoreDay chores;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 15.0),
          child: Center(
            child: Text(
              "Chores for ${DateFormat("EEEE, MMM d").format(date)}:",
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontFamily: "RobotoSlab",
                fontSize: 20,
              ),
            ),
          ),
        ),
        ...chores.chores.map(
          (c) => Center(
            child: ChoreCard(
              chores: chores,
              chore: c,
              name: name,
              date: date,
            ),
          ),
        ),
        // ScoreCard(score: chores.calculateDailyScore())
      ],
    );
  }
}
