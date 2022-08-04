import 'package:bloc/bloc.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/bloc/student_schedule_state.dart';
import 'package:kai_schedule/utility/exceptions.dart';
import 'package:kai_schedule/utility/get_week_parity.dart' as week_parity;
import 'package:shared_preferences/shared_preferences.dart';
import '../schedule_repository/schedule_repository.dart';

class StudentScheduleCubit extends Cubit<StudentScheduleState> {
  final ScheduleRepository _scheduleRepository;
  StudentScheduleCubit(this._scheduleRepository)
      : super(StudentScheduleState(
          isButton: true,
          isWeekEven: week_parity.isEven(),
          switchValue: week_parity.isEven(),
        ));
  Future<void> getStudentScheduleByGroup(
    String group,
  ) async {
    if (group.isEmpty) return;
    if (state.group == group && state.isButton == false) return;
    try {
      emit(state.copyWith(group: group, isLoading: true, isButton: true));
      final schedule =
          await _scheduleRepository.getStudentScheduleByGroup(group: group);
      emit(state.copyWith(data: schedule, isLoading: false));
      await setGroupToStorage(group);
    } on ApiClientException {
      emit(state.copyWith(status: ResponseStatus.failure, isLoading: false));
    }
  }

  void toggleTextField(bool isButton) {
    emit(state.copyWith(isButton: !isButton));
  }

  void toggleSwitch(bool value) {
    emit(state.copyWith(switchValue: value));
  }

  Future<void> setGroupToStorage(String group) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('group', group);
  }

  void checkIfGroupStored() async {
    final prefs = await SharedPreferences.getInstance();
    final group = prefs.getString('group');
    if (group == null) return;
    emit(state.copyWith(
      group: group,
      isButton: true,
    ));
    await getStudentScheduleByGroup(group);
  }
}
