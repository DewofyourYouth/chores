import 'dart:developer';

import 'package:chores/database/queries.dart';
import 'package:flutter/material.dart';

enum ChoreType { daily, alternation }

class NewChore extends StatefulWidget {
  const NewChore({Key? key}) : super(key: key);

  @override
  State<NewChore> createState() => _NewChoreState();
}

class _NewChoreState extends State<NewChore> {
  final choreTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    // choreTextController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    descriptionTextController.dispose();
    choreTextController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    log('Chore: ${choreTextController.text}');
    log("Description: ${descriptionTextController.text}");
  }

  void addNewChore() {
    addDailyChores(
      choreTextController.text,
      descriptionTextController.text,
    );
    _printLatestValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Chore"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: choreTextController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter chore here',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: TextFormField(
              controller: descriptionTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter description here"),
            ),
          ),
          ElevatedButton(
            onPressed: addNewChore,
            child: const Text("Add Chore"),
          )
        ],
      ),
    );
  }
}
