import 'dart:convert';

import 'package:chores/utils/dates.dart';
import 'package:flutter/foundation.dart';

import 'package:chores/components/chores/utils.dart';
import 'package:chores/constants.dart';

class Chore {
  String chore;
  bool done;
  bool isAlternating;

  Chore({
    required this.chore,
    required this.done,
    required this.isAlternating,
  });

  Chore copyWith({
    String? chore,
    bool? done,
    bool? isAlternating,
  }) {
    return Chore(
      chore: chore ?? this.chore,
      done: done ?? this.done,
      isAlternating: isAlternating ?? this.isAlternating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chore': chore,
      'done': done,
      'isAlternating': isAlternating,
    };
  }

  factory Chore.fromMap(Map<String, dynamic> map) {
    return Chore(
      chore: map['chore'] ?? '',
      done: map['done'] ?? false,
      isAlternating: map['isAlternating'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chore.fromJson(String source) => Chore.fromMap(json.decode(source));

  @override
  String toString() => 'Chore(chore: $chore, done: $done)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chore && other.chore == chore && other.done == done;
  }

  @override
  int get hashCode => chore.hashCode ^ done.hashCode;
}

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
      chores: List<Chore>.from(map['chores']?.map((x) => Chore.fromMap(x))),
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
  var chores = daiyChores
      .map((c) => Chore(chore: c, done: false, isAlternating: false))
      .toList();
  var id = createChoreDayId(kidName, date);
  return ChoreDay(id: id, kidName: kidName, date: date, chores: chores);
}
