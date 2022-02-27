import 'dart:developer';

import 'package:chores/controllers/chore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// enum ChoreType { daily, alternation }

class NewChore extends StatelessWidget {
  final controller = Get.put(ChoreController());

  NewChore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Add a new chore",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: TextFormField(
              controller: controller.choreTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter chore here',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: TextFormField(
              controller: controller.descriptionTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter description here"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Obx(
              () => CheckboxListTile(
                title: const Text("Alternating chore"),
                value: controller.isAlternating.value,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? val) {
                  controller.toggleIsAlternating();
                  val = controller.isAlternating.value;
                  log(controller.isAlternating.toString());
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: controller.addNewChore,
              child: const Text("Add Chore"),
            ),
          )
        ],
      ),
    );
  }
}
