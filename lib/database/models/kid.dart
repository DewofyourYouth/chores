import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Kid {
  ObjectId id;
  String name;
  Kid({
    required this.id,
    required this.name,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toHexString(),
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Kid(id: $id, name: $name,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Kid && other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class KidPoints {
  final Kid kid;
  final int points;
  KidPoints({required this.kid, required this.points});

  @override
  String toString() {
    return "KidPoints(name: ${kid.toString()}, points: $points";
  }
}
