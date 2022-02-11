// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

class ChoreLog {
  DateTime calendarDay;
  String kidName;
  String chore;
  bool isDone;
  bool isAlternating;
  ChoreLog({
    // required this.id,
    required this.calendarDay,
    required this.kidName,
    required this.chore,
    required this.isDone,
    required this.isAlternating,
  });

  ChoreLog copyWith({
    // ObjectId? id,
    DateTime? calendarDay,
    String? kidName,
    String? chore,
    bool? isDone,
    bool? isAlternating,
  }) {
    return ChoreLog(
      calendarDay: calendarDay ?? this.calendarDay,
      kidName: kidName ?? this.kidName,
      chore: chore ?? this.chore,
      isDone: isDone ?? this.isDone,
      isAlternating: isAlternating ?? this.isAlternating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id':
          "${calendarDay.toString()}:$kidName:${chore.split(' ').map((s) => s.trim()).join('')}",
      'calendarDay': calendarDay,
      'kidName': kidName,
      'chore': chore,
      'isDone': isDone,
      'isAlternating': isAlternating,
    };
  }

  factory ChoreLog.fromMap(Map<String, dynamic> map) {
    return ChoreLog(
      calendarDay: DateTime.fromMillisecondsSinceEpoch(map['calendarDay']),
      kidName: map['kidName'] ?? '',
      chore: map['chore'] ?? '',
      isDone: map['isDone'] ?? false,
      isAlternating: map['isAlternating'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoreLog.fromJson(String source) =>
      ChoreLog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChoreLog(calendarDay: $calendarDay, kidName: $kidName, chore: $chore, isDone: $isDone, isAlternating: $isAlternating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChoreLog &&
        other.calendarDay == calendarDay &&
        other.kidName == kidName &&
        other.chore == chore &&
        other.isDone == isDone &&
        other.isAlternating == isAlternating;
  }

  @override
  int get hashCode {
    return calendarDay.hashCode ^
        kidName.hashCode ^
        chore.hashCode ^
        isDone.hashCode ^
        isAlternating.hashCode;
  }
}
