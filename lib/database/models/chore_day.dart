import 'dart:convert';
import 'dart:developer';

import 'package:chores/database/models/chore_constants.dart';
import 'package:chores/database/models/chores/daily_chore.dart';
import 'package:chores/utils/dates.dart';
import 'package:chores/utils/strings.dart';
import 'package:chores/utils/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:chores/components/chores/utils.dart';
import 'package:chores/constants.dart';

import 'chores/alternating_chore.dart';
import 'chores/chore.dart';

class ChoreDay {
  String id;
  String kidName;
  DateTime date;
  List<Chore> chores;

  ChoreDay({
    required this.id,
    required this.kidName,
    required this.date,
    required this.chores,
  });

  ChoreDay copyWith({
    String? id,
    String? kidName,
    DateTime? date,
    List<Chore>? chores,
  }) {
    return ChoreDay(
      id: id ?? this.id,
      kidName: kidName ?? this.kidName,
      date: date ?? this.date,
      chores: chores ?? this.chores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'kidName': kidName,
      'date': date,
      'chores': chores.map((x) => x.toMap()).toList(),
    };
  }

  factory ChoreDay.fromMap(Map<String, dynamic> map) {
    return ChoreDay(
      id: map['_id'] ?? '',
      kidName: map['kidName'] ?? '',
      date: map['Date'] ?? getDay(),
      chores: List<Chore>.from(map['chores']?.map((x) => chooseFromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoreDay.fromJson(String source) =>
      ChoreDay.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChoreDay(id: $id, kidName: $kidName, date: $date, chores: $chores)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChoreDay &&
        other.id == id &&
        other.kidName == kidName &&
        other.date == date &&
        listEquals(other.chores, chores);
  }

  @override
  int get hashCode =>
      id.hashCode ^ kidName.hashCode ^ date.hashCode ^ chores.hashCode;
}

ChoreDay initializeChoreDay(String kidName, DateTime date) {
  List<Chore> chores = dailyChores
      .map((c) => DailyChore(
            chore: c,
            done: ChoreState.unmarked,
          ))
      .toList();
  var altMap = createDailyAlternating(date);
  if (altMap.isNotEmpty) {
    chores.add(AlternatingChore(
      chore: createDailyAlternating(date)[kidName],
      done: ChoreState.unmarked,
    ));
  }
  var id = createChoreDayId(kidName, date);
  return ChoreDay(id: id, kidName: kidName, date: date, chores: chores);
}

Map<dynamic, dynamic> createDailyAlternating(DateTime date) {
  if (!date.isAlternatingDay()) {
    return {};
  }
  var wkDay = date.weekday;
  var monthWeek = (date.day / 7).floor();
  var rotateOffset = wkDay + monthWeek;
  var room = rotateOffset % 2 == 0 ? 'kitchen' : 'living room';
  var rAlternatingChores = rotateList(
      alternatingChores
          .map((chore) => chore.contains("{room}")
              ? chore.formatWithMap({"room": room})
              : chore)
          .toList(),
      rotateOffset);
  var m = {};
  for (int i = 0; i < kids.length; i++) {
    m[kids[i]] = rAlternatingChores[i];
  }
  return m;
}
