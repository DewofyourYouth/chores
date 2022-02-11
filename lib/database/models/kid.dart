import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Kid {
  ObjectId id;
  String name;
  int dailyPoints;
  int alternatingPoints;
  Kid({
    required this.id,
    required this.name,
    required this.dailyPoints,
    required this.alternatingPoints,
  });

  Kid copyWith({
    ObjectId? id,
    String? name,
    int? dailyPoints,
    int? alternatingPoints,
  }) {
    return Kid(
      id: id ?? this.id,
      name: name ?? this.name,
      dailyPoints: dailyPoints ?? this.dailyPoints,
      alternatingPoints: alternatingPoints ?? this.alternatingPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toHexString(),
      'name': name,
      'dailyPoints': dailyPoints,
      'alternatingPoints': alternatingPoints,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Kid(id: $id, name: $name, dailyPoints: $dailyPoints, alternatingPoints: $alternatingPoints)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Kid &&
        other.id == id &&
        other.name == name &&
        other.dailyPoints == dailyPoints &&
        other.alternatingPoints == alternatingPoints;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dailyPoints.hashCode ^
        alternatingPoints.hashCode;
  }
}
