import 'dart:developer';

import 'package:chores/database/queries.dart';
import 'package:flutter/material.dart';

import '../../database/models/chore_day.dart';

class ChoreCard extends StatefulWidget {
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

  @override
  State<ChoreCard> createState() => _ChoreCardState();
}

class _ChoreCardState extends State<ChoreCard> {
  bool localDone = false;
  Chore getCurrentChore() {
    var cl = widget.chores.chores;
    return cl[cl.indexWhere((element) => element.chore == widget.chore)];
  }

  void toggleChore() {
    var currentChore = getCurrentChore();
    currentChore.done = !widget.done;
    setState(() {
      localDone = currentChore.done;
    });
    log("marking ${currentChore.chore} as ${currentChore.done ? 'done' : 'not done'}");
    updateChore(widget.chores);
  }

  IconButton getDoneIcon() {
    setState(() {
      localDone = getCurrentChore().done;
    });
    return !localDone
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
  }

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
            TextButton(
                child: const Text("Done"),
                onPressed: () => {
                      if (!widget.done) {toggleChore()}
                    }),
            TextButton(
                onPressed: () => {
                      if (widget.done) {toggleChore()}
                    },
                child: const Text("Not Done"))
          ],
        )
      ],
    ));
  }
}
