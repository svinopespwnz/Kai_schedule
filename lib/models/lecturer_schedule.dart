import 'package:json_annotation/json_annotation.dart';
part 'lecturer_schedule.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class LecturerSchedule {
  final List<LecturerLesson>? l1;
  final List<LecturerLesson>? l2;
  final List<LecturerLesson>? l3;
  final List<LecturerLesson>? l4;
  final List<LecturerLesson>? l5;
  final List<LecturerLesson>? l6;

  LecturerSchedule(
      {required this.l1,
      required this.l2,
      required this.l3,
      required this.l4,
      required this.l5,
      required this.l6});
  factory LecturerSchedule.fromJson(Map<String, dynamic> json) =>
      _$LecturerScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$LecturerScheduleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class LecturerLesson {
  final int groupId;
  final int dayNum;
  final int disciplNum;
  final String dayDate;
  final String audNum;
  final String disciplType;
  final String buildNum;
  final String disciplName;
   String group;
  final String dayTime;

  LecturerLesson(
      {required this.groupId,
      required this.dayNum,
      required this.disciplNum,
      required this.dayDate,
      required this.audNum,
      required this.disciplType,
      required this.buildNum,
      required this.disciplName,
      required this.group,
      required this.dayTime});
  factory LecturerLesson.fromJson(Map<String, dynamic> json) =>
      _$LecturerLessonFromJson(json);
  Map<String, dynamic> toJson() => _$LecturerLessonToJson(this);
}
