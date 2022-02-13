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

  void toggleChore() {
    setState(() {
      done = !done;
    });
    log("marking chore as ${done ? 'done' : 'not done'}");
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
          onPressed: toggleChore,
        )
      : IconButton(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          onPressed: toggleChore,
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
            TextButton(child: const Text("Done"), onPressed: toggleChore),
            TextButton(onPressed: toggleChore, child: const Text("Not Done"))
          ],
        )
      ],
    ));
  }
}
