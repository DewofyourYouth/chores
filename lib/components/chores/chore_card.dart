import 'dart:developer';

import 'package:chores/database/queries.dart';
import 'package:flutter/material.dart';

import '../../database/models/chore_day.dart';

class ChoreCard extends StatelessWidget {
  final String chore;
  final ChoreDay chores;
  final String name;
  final bool done;
  const ChoreCard({
    Key? key,
    required this.chore,
    required this.name,
    required this.done,
    required this.chores,
  }) : super(key: key);

  void toggleChore() {
    // log("marking chore as ${done ? 'done' : 'not done'}");
    var cl = chores.chores;
    var currentChore = cl[cl.indexWhere((element) => element.chore == chore)];
    log(currentChore.done.toString());
    currentChore.done = !done;
    // var choreLog = ChoreLog(
    //     calendarDay: getDay(),
    //     kidName: name,
    //     chore: chore,
    //     isDone: done,
    //     isAlternating: false);
    log(chores.toString());
    insertChore(chores);
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
            chore,
            style: const TextStyle(fontFamily: "RobotoSlab"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                child: const Text("Done"),
                onPressed: () => {
                      if (!done) {toggleChore()}
                    }),
            TextButton(
                onPressed: () => {
                      if (done) {toggleChore()}
                    },
                child: const Text("Not Done"))
          ],
        )
      ],
    ));
  }
}
