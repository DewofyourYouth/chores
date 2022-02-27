import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/queries.dart';

class ChoreController extends GetxController {
  final choreTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  var isAlternating = false.obs;

  @override
  void onInit() {
    choreTextController.text = "";
    descriptionTextController.text = "";
    isAlternating = false.obs;
    super.onInit();
  }

  @override
  void onClose() {
    choreTextController.dispose();
    descriptionTextController.dispose();
    super.onClose();
  }

  void _printLatestValue() {
    log('Chore: ${choreTextController.text}');
    log("Description: ${descriptionTextController.text}");
  }

  toggleIsAlternating() {
    isAlternating.toggle();
  }

  void addNewChore() {
    addDailyChores(
      choreTextController.text,
      descriptionTextController.text,
      isAlternating.value,
    );
    _printLatestValue();
    choreTextController.text = "";
    descriptionTextController.text = "";
  }
}
