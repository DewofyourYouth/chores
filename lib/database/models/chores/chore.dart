import 'package:chores/database/models/chore_constants.dart';

abstract class Chore {
  String chore;
  ChoreState done;
  Chore({
    required this.chore,
    required this.done,
  });
  int getPoints();

  bool isAlternating();
  Map<String, dynamic> toMap();
}
