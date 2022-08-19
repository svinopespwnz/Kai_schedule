// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      l1: (json['1'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l2: (json['2'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l3: (json['3'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l4: (json['4'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l5: (json['5'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      l6: (json['6'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      '1': instance.l1?.map((e) => e.toJson()).toList(),
      '2': instance.l2?.map((e) => e.toJson()).toList(),
      '3': instance.l3?.map((e) => e.toJson()).toList(),
      '4': instance.l4?.map((e) => e.toJson()).toList(),
      '5': instance.l5?.map((e) => e.toJson()).toList(),
      '6': instance.l6?.map((e) => e.toJson()).toList(),
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      prepodNameEnc: json['prepodNameEnc'] as String,
      dayDate: json['dayDate'] as String,
      audNum: json['audNum'] as String,
      disciplName: json['disciplName'] as String,
      buildNum: json['buildNum'] as String,
      orgUnitName: json['orgUnitName'] as String,
      dayTime: json['dayTime'] as String,
      dayNum: json['dayNum'] as String,
      potok: json['potok'] as String,
      prepodName: json['prepodName'] as String,
      disciplNum: json['disciplNum'] as String,
      orgUnitId: json['orgUnitId'] as String,
      prepodLogin: json['prepodLogin'] as String,
      disciplType: json['disciplType'] as String,
      disciplNameEnc: json['disciplNameEnc'] as String,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'prepodNameEnc': instance.prepodNameEnc,
      'dayDate': instance.dayDate,
      'audNum': instance.audNum,
      'disciplName': instance.disciplName,
      'buildNum': instance.buildNum,
      'orgUnitName': instance.orgUnitName,
      'dayTime': instance.dayTime,
      'dayNum': instance.dayNum,
      'potok': instance.potok,
      'prepodName': instance.prepodName,
      'disciplNum': instance.disciplNum,
      'orgUnitId': instance.orgUnitId,
      'prepodLogin': instance.prepodLogin,
      'disciplType': instance.disciplType,
      'disciplNameEnc': instance.disciplNameEnc,
    };
