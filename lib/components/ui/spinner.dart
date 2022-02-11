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
    return SizedBox(
      height: 1,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40.0, 0, 20.0),
            child: SpinKitPianoWave(
              color: Colors.deepPurple,
              size: 200.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              spinnerMsg,
              style: const TextStyle(fontFamily: "RobotoSlab"),
            ),
          ),
        ],
      ),
    );
  }
}
