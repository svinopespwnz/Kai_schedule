import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/models/lecturer_schedule.dart';



class LecturerScheduleState {
  final ResponseStatus status;
  final String name;
  final bool isWeekEven;
  final List<String> listOfLecturers;
  final List<List<LecturerLesson>?> data;
  final bool isLoading;
  LecturerScheduleState(
      {this.status = ResponseStatus.success,
      this.name = '',
      this.isWeekEven = false,
      this.isLoading = false,
      List<String>? listOfLecturers,
        List<List<LecturerLesson>?>? data})
      : data = data ?? [],
        listOfLecturers = listOfLecturers ?? [];

  LecturerScheduleState copyWith({
    ResponseStatus? status,
    String? name,
    bool? isWeekEven,
    List<String>? listOfLecturers,
    List<List<LecturerLesson>?>? data,
    bool? isLoading,
  }) {
    return LecturerScheduleState(
      status: status ?? this.status,
      name: name ?? this.name,
      isWeekEven: isWeekEven ?? this.isWeekEven,
      listOfLecturers: listOfLecturers ?? this.listOfLecturers,
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LecturerScheduleState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          name == other.name &&
          isWeekEven == other.isWeekEven &&
          listOfLecturers == other.listOfLecturers &&
          data == other.data &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      status.hashCode ^
      name.hashCode ^
      isWeekEven.hashCode ^
      listOfLecturers.hashCode ^
      data.hashCode ^
      isLoading.hashCode;
}
