import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Schedule {
  List<Lesson> l1;
  List<Lesson> l2;
  List<Lesson> l3;
  List<Lesson> l4;
  List<Lesson> l5;
  List<Lesson> l6;

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
  String prepodNameEnc;
  String dayDate;
  String audNum;
  String disciplName;
  String buildNum;
  String orgUnitName;
  String dayTime;
  String dayNum;
  String potok;
  String prepodName;
  String disciplNum;
  String orgUnitId;
  String prepodLogin;
  String disciplType;
  String disciplNameEnc;

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
