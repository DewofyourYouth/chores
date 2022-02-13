import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PianoSpinner extends StatelessWidget {
  final String spinnerMsg;
  const PianoSpinner({
    Key? key,
    required this.spinnerMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(spinnerMsg);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 40.0, 0, 20.0),
            child: SpinKitPianoWave(
              color: Colors.deepPurple,
              size: 100.0,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              spinnerMsg,
              style: const TextStyle(fontFamily: "RobotoSlab"),
            ),
          ),
        ),
      ],
    );
  }
}
