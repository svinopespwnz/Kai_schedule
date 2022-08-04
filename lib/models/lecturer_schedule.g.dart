// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecturer_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LecturerSchedule _$LecturerScheduleFromJson(Map<String, dynamic> json) =>
    LecturerSchedule(
      l1: (json['1'] as List<dynamic>?)
          ?.map((e) => LecturerLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l2: (json['2'] as List<dynamic>?)
          ?.map((e) => LecturerLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l3: (json['3'] as List<dynamic>?)
          ?.map((e) => LecturerLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l4: (json['4'] as List<dynamic>?)
          ?.map((e) => LecturerLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l5: (json['5'] as List<dynamic>?)
          ?.map((e) => LecturerLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l6: (json['6'] as List<dynamic>?)
          ?.map((e) => LecturerLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LecturerScheduleToJson(LecturerSchedule instance) =>
    <String, dynamic>{
      '1': instance.l1?.map((e) => e.toJson()).toList(),
      '2': instance.l2?.map((e) => e.toJson()).toList(),
      '3': instance.l3?.map((e) => e.toJson()).toList(),
      '4': instance.l4?.map((e) => e.toJson()).toList(),
      '5': instance.l5?.map((e) => e.toJson()).toList(),
      '6': instance.l6?.map((e) => e.toJson()).toList(),
    };

LecturerLesson _$LecturerLessonFromJson(Map<String, dynamic> json) =>
    LecturerLesson(
      groupId: json['groupId'] as int,
      dayNum: json['dayNum'] as int,
      disciplNum: json['disciplNum'] as int,
      dayDate: json['dayDate'] as String,
      audNum: json['audNum'] as String,
      disciplType: json['disciplType'] as String,
      buildNum: json['buildNum'] as String,
      disciplName: json['disciplName'] as String,
      group: json['group'] as String,
      dayTime: json['dayTime'] as String,
    );

Map<String, dynamic> _$LecturerLessonToJson(LecturerLesson instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'dayNum': instance.dayNum,
      'disciplNum': instance.disciplNum,
      'dayDate': instance.dayDate,
      'audNum': instance.audNum,
      'disciplType': instance.disciplType,
      'buildNum': instance.buildNum,
      'disciplName': instance.disciplName,
      'group': instance.group,
      'dayTime': instance.dayTime,
    };
