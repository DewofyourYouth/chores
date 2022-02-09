import 'package:flutter/material.dart';

class KidInput extends StatelessWidget {
  const KidInput({
    Key? key,
    required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: const InputDecoration(
        labelText: "Name",
        helperText: "Input a kid's name here!",
        border: OutlineInputBorder(),
      ),
    );
  }
}
