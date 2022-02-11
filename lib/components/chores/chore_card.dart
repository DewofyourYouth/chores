import 'dart:developer';

import 'package:chores/database/models/chore_log.dart';
import 'package:chores/database/queries.dart';
import 'package:chores/utils/dates.dart';
import 'package:flutter/material.dart';

class ChoreCard extends StatefulWidget {
  final String chore;
  final String name;
  const ChoreCard({
    Key? key,
    required this.chore,
    required this.name,
  }) : super(key: key);

  @override
  State<ChoreCard> createState() => _ChoreCardState();
}

class _ChoreCardState extends State<ChoreCard> {
  bool done = false;

  void toggleDone() {
    setState(() {
      done = !done;
    });
  }

  void markChoreAsDone() {
    log("marking as done");
    setState(() {
      done = true;
    });
    DateTime now = DateTime.now();
    ChoreLog choreLog = ChoreLog(
        calendarDay: getDay(),
        kidName: widget.name,
        chore: widget.chore,
        isDone: done,
        isAlternating: false);
    insertChore(choreLog);
  }

  IconButton getDoneIcon() => !done
      ? IconButton(
          icon: const Icon(Icons.radio_button_unchecked),
          onPressed: toggleDone,
        )
      : IconButton(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          onPressed: toggleDone,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: getDoneIcon(),
          title: Text(
            widget.chore,
            style: const TextStyle(fontFamily: "RobotoSlab"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(child: const Text("Done"), onPressed: markChoreAsDone),
            TextButton(
                onPressed: markChoreAsDone, child: const Text("Not Done"))
          ],
        )
      ],
    ));
  }
}
