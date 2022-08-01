import 'package:bloc/bloc.dart';
import 'package:kai_schedule/bloc/states.dart';
import 'package:kai_schedule/helpers/get_week_parity.dart' as week_parity;
import '../schedule_repository/schedule_repository.dart';

class StudentScheduleCubit extends Cubit<StudentScheduleState> {
  final ScheduleRepository _scheduleRepository;
  StudentScheduleCubit(this._scheduleRepository)
      : super(StudentScheduleState(
            isWeekEven: week_parity.isEven(),
            switchValue: week_parity.isEven(),
            ));
  Future<void> getStudentScheduleByGroup(String group,
     ) async {
    if (group.isEmpty) return;
    if (state.group == group) return;
    emit(state.copyWith(group: group));
    final schedule = await _scheduleRepository.getStudentScheduleByGroup(
        group: group);
    emit(state.copyWith(data: schedule));
  }

  void toggleTextField(bool isButton) {
    emit(state.copyWith(isButton: !isButton));
  }

  void toggleSwitch(bool value) {
    emit(state.copyWith(switchValue: value));

  }
}
