import 'dart:developer';

import 'package:chores/database/queries.dart';
import 'package:flutter/material.dart';

import '../../database/models/chore_day.dart';
import '../ui/done_indicator.dart';

class ChoreCard extends StatefulWidget {
  final String chore;
  final ChoreDay chores;
  final String name;
  const ChoreCard({
    Key? key,
    required this.chore,
    required this.name,
    // required this.done,
    required this.chores,
  }) : super(key: key);

  @override
  State<ChoreCard> createState() => _ChoreCardState();
}

class _ChoreCardState extends State<ChoreCard> {
  bool done = false;
  Chore getCurrentChore() {
    var cl = widget.chores.chores;
    return cl[cl.indexWhere((element) => element.chore == widget.chore)];
  }

  void toggleChore() {
    var currentChore = getCurrentChore();
    setState(() {
      done = !currentChore.done;
    });
    currentChore.done = done;
    log("marking ${currentChore.chore} as ${currentChore.done ? 'done' : 'not done'}");
    updateChore(widget.chores);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: IconButton(
            icon: DoneIndicator(done: getCurrentChore().done),
            onPressed: toggleChore,
          ),
          title: Text(
            widget.chore,
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
