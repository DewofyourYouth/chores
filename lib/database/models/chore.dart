import 'dart:convert';

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
