import 'package:kai_schedule/models/student_schedule.dart';

class StudentScheduleState {
  final bool isButton;
  final bool isWeekEven;
  final bool switchValue;
  final  List<List<List<Lesson>>> data;
  final String group;

  StudentScheduleState(
      {this.isButton = false,
      this.isWeekEven = false,
      this.switchValue = false,
      this.group='',
      List<List<List<Lesson>>>? data})
      : data = data ?? [];

  StudentScheduleState copyWith({
    bool? isButton,
    bool? isWeekEven,
    bool? switchValue,
    List<List<List<Lesson>>>? data,
    String? group,
  }) {
    return StudentScheduleState(
      isButton: isButton ?? this.isButton,
      isWeekEven: isWeekEven ?? this.isWeekEven,
      switchValue: switchValue ?? this.switchValue,
      data: data ?? this.data,
      group: group ?? this.group,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentScheduleState &&
          runtimeType == other.runtimeType &&
          isButton == other.isButton &&
          isWeekEven == other.isWeekEven &&
          switchValue == other.switchValue &&
          data == other.data &&
          group == other.group;

  @override
  int get hashCode =>
      isButton.hashCode ^
      isWeekEven.hashCode ^
      switchValue.hashCode ^
      data.hashCode ^
      group.hashCode;
}
