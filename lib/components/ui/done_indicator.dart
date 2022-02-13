import 'package:flutter/material.dart';

class DoneIndicator extends StatelessWidget {
  final bool done;
  const DoneIndicator({Key? key, required this.done}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return done
        ? const Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : const Icon(
            Icons.radio_button_unchecked,
            color: Colors.orange,
          );
  }
}
