import 'package:bloc/bloc.dart';
import 'package:kai_schedule/bloc/lecturer_schedule/lecturer_schedule_state.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/repository/repository.dart';
import 'package:kai_schedule/utility/exceptions.dart';
import 'package:kai_schedule/utility/get_week_parity.dart' as week_parity;

class LecturerScheduleCubit extends Cubit<LecturerScheduleState> {
  final ApiRepository _scheduleRepository;
  LecturerScheduleCubit(this._scheduleRepository)
      : super(LecturerScheduleState(
          isWeekEven: week_parity.isEven(),
        ));
  Future<void> fillLecturersList() async {
    try {
      final lecturers = await _scheduleRepository.getLecturersNamesList();
      emit(state.copyWith(listOfLecturers: lecturers));
    } on ApiClientException {
      emit(state.copyWith(status: ResponseStatus.failure));
    }
  }

  Future<void> getLecturersSchedule(String name) async {
    if (name.isEmpty) return;
    if (state.name == name && state.status==ResponseStatus.success) return;
    try {
      emit(state.copyWith(
        name: name,
        isLoading: true,
        status: ResponseStatus.success
      ));
      final schedule = await _scheduleRepository.getLecturerSchedule(name);
      emit(state.copyWith(data: schedule, isLoading: false,status: ResponseStatus.success));
    } on ApiClientException {
      emit(state.copyWith(status: ResponseStatus.failure,isLoading: false));
    }
  }
}