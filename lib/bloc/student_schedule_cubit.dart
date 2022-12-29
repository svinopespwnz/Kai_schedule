import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/bloc/student_schedule_state.dart';
import 'package:kai_schedule/models/student_schedule.dart';
import 'package:kai_schedule/utility/exceptions.dart';
import 'package:kai_schedule/utility/get_week_parity.dart' as week_parity;
import '../repository/repository.dart';

class StudentScheduleCubit extends Cubit<StudentScheduleState>
    with HydratedMixin {
  final ApiRepository _scheduleRepository;
  StudentScheduleCubit(this._scheduleRepository)
      : super(StudentScheduleState(
          isButton: true,
          isWeekEven: week_parity.isEven(),
          switchValue: week_parity.isEven(),
        ));
  Future<void> getStudentScheduleByGroup(
    String group,
  ) async {
    if (group.isEmpty) {
      emit(state.copyWith(isButton: true));
      return;
    }
    if (state.group == group &&
        state.isButton == false &&
        state.status == ResponseStatus.success) {
      emit(state.copyWith(isButton: true));
      return;
    }
    try {
      emit(state.copyWith(group: group, isLoading: true, isButton: true));
      final schedule =
          await _scheduleRepository.getStudentScheduleByGroup(group: group);
      emit(state.copyWith(
          data: schedule,
          isButton: true,
          isLoading: false,
          status: ResponseStatus.success));
    } on ApiClientException {
      emit(state.copyWith(
          status: ResponseStatus.failure, isLoading: false, isButton: true));
    } on GroupDoesntExistException {
      emit(state.copyWith(
          group: '',
          status: ResponseStatus.groupFailure,
          isLoading: false,
          isButton: true));
    }
  }

  Future<void> didScheduleUpdate() async {
    if (state.group.isNotEmpty) {
      try {
        emit(state.copyWith(isLoading: true, isButton: true));
        final schedule = await _scheduleRepository.getStudentScheduleByGroup(
            group: state.group);
        if (state.data == schedule) {
          return;
        } else {
          emit(state.copyWith(
              data: schedule,
              isButton: true,
              isLoading: false,
              status: ResponseStatus.success));
        }
      } on ApiClientException {
        emit(state.copyWith(
            status: ResponseStatus.failure, isLoading: false, isButton: true));
      }
    }
  }

  void toggleTextField(bool isButton) {
    emit(state.copyWith(isButton: !isButton));
  }

  void toggleSwitch(bool value) {
    emit(state.copyWith(switchValue: value));
  }

  @override
  StudentScheduleState? fromJson(Map<String, dynamic> json) {
    try {
      final data = List<List<List<Lesson>>>.from(json['data'].map((e) =>
          List<List<Lesson>>.from(e.map(
              (e) => List<Lesson>.from(e.map((e) => Lesson.fromJson(e)))))));
      return StudentScheduleState(
          group: json['group'],
          data: data,
          isButton: true,
          isWeekEven: week_parity.isEven(),
          switchValue: week_parity.isEven());
    } catch (_) {
      return StudentScheduleState(group: '1810');
    }
  }

  @override
  Map<String, dynamic>? toJson(StudentScheduleState state) {
    final map = state.data.isNotEmpty
        ? {'group': state.group, 'data': state.data}
        : null;
    return map;
  }
}
