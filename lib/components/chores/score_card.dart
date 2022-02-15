import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final int score;
  const ScoreCard({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("Daily Score: $score"),
        ),
      ),
    );
  }
}
