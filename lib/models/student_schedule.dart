import 'package:json_annotation/json_annotation.dart';

part 'student_schedule.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Schedule {
  final List<Lesson>? l1;
  final List<Lesson>? l2;
  final List<Lesson>? l3;
  final List<Lesson>? l4;
  final List<Lesson>? l5;
  final List<Lesson>? l6;

  Schedule(
      {required this.l1,
      required this.l2,
      required this.l3,
      required this.l4,
      required this.l5,
      required this.l6});
  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Lesson {
  final String prepodNameEnc;
  final String dayDate;
  final String audNum;
  final String disciplName;
  final String buildNum;
  final String orgUnitName;
  final String dayTime;
  final String dayNum;
  final String potok;
  final String prepodName;
  final String disciplNum;
  final String orgUnitId;
  final String prepodLogin;
  final String disciplType;
  final String disciplNameEnc;

  Lesson(
      {required this.prepodNameEnc,
      required this.dayDate,
      required this.audNum,
      required this.disciplName,
      required this.buildNum,
      required this.orgUnitName,
      required this.dayTime,
      required this.dayNum,
      required this.potok,
      required this.prepodName,
      required this.disciplNum,
      required this.orgUnitId,
      required this.prepodLogin,
      required this.disciplType,
      required this.disciplNameEnc});

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
