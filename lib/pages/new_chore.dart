import 'dart:developer';

import 'package:chores/controllers/chore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ChoreType { daily, alternation }

class NewChore extends StatelessWidget {
  final controller = Get.put(ChoreController());

  NewChore({Key? key}) : super(key: key);

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
              controller: controller.choreTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter chore here',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
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
              () => Checkbox(
                value: controller.isAlternating.value,
                onChanged: (bool? val) {
                  controller.toggleIsAlternating();
                  val = controller.isAlternating.value;
                  log(controller.isAlternating.toString());
                },
                // onChanged: controller.toggleAlternating,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: controller.addNewChore,
            child: const Text("Add Chore"),
          )
        ],
      ),
    );
  }
}
