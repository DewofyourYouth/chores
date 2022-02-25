import 'dart:developer';

import 'package:chores/database/models/chore_constants.dart';
import 'package:chores/database/queries.dart';
import 'package:flutter/material.dart';

import '../../database/models/chores/chore.dart';
import '../../database/models/chore_day.dart';
import '../ui/done_indicator.dart';

class ChoreCard extends StatefulWidget {
  final DateTime date;
  final Chore chore;
  final ChoreDay chores;
  final String name;
  const ChoreCard({
    Key? key,
    required this.chore,
    required this.name,
    required this.date,
    // required this.done,
    required this.chores,
  }) : super(key: key);

  @override
  State<ChoreCard> createState() => _ChoreCardState();
}

class _ChoreCardState extends State<ChoreCard> {
  ChoreState done = ChoreState.unmarked;
  Chore getCurrentChore() {
    var cl = widget.chores.chores;
    return cl[cl.indexWhere((element) => element.chore == widget.chore.chore)];
  }

  ChoreState cs = ChoreState.unmarked;

  void toggleChore() {
    var currentChore = getCurrentChore();
    setState(() {
      done = currentChore.done.next();
    });
    currentChore.done = done;
    updateChore(widget.chores, widget.date);
  }

  @override
  Widget build(BuildContext context) {
    var alternating = widget.chore.isAlternating();
    return Card(
        color: !alternating ? Colors.grey[600] : Colors.blueGrey,
        child: ListTile(
          leading: IconButton(
            icon: DoneIndicator(done: getCurrentChore().done),
            onPressed: toggleChore,
          ),
          title: Text(
            widget.chore.chore,
            style: TextStyle(
                fontFamily: "RobotoSlab",
                fontWeight: alternating ? FontWeight.bold : FontWeight.normal,
                color: alternating ? Colors.yellow : Colors.white),
          ),
        ));
  }
}
