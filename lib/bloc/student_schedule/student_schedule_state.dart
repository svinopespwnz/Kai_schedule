import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/models/student_schedule.dart';

class StudentScheduleState {
  final ResponseStatus status;
  final bool isButton;
  final bool isWeekEven;
  final bool switchValue;
  final List<List<List<Lesson>>> data;
  final String group;
  final bool isLoading;

  StudentScheduleState(
      {this.status = ResponseStatus.success,
      this.isButton = false,
      this.isWeekEven = false,
      this.switchValue = false,
      this.group = '',
      this.isLoading = false,
      List<List<List<Lesson>>>? data})
      : data = data ?? [];

  StudentScheduleState copyWith({
    ResponseStatus? status,
    bool? isButton,
    bool? isWeekEven,
    bool? switchValue,
    List<List<List<Lesson>>>? data,
    String? group,
    bool? isLoading,
  }) {
    return StudentScheduleState(
      status: status ?? this.status,
      isButton: isButton ?? this.isButton,
      isWeekEven: isWeekEven ?? this.isWeekEven,
      switchValue: switchValue ?? this.switchValue,
      data: data ?? this.data,
      group: group ?? this.group,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentScheduleState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          isButton == other.isButton &&
          isWeekEven == other.isWeekEven &&
          switchValue == other.switchValue &&
          data == other.data &&
          group == other.group &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      status.hashCode ^
      isButton.hashCode ^
      isWeekEven.hashCode ^
      switchValue.hashCode ^
      data.hashCode ^
      group.hashCode ^
      isLoading.hashCode;
}
