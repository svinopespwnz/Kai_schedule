import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_schedule/bloc/auth_status_enum.dart';
import 'package:kai_schedule/bloc/student_score/student_score_events.dart';
import 'package:kai_schedule/bloc/student_score/student_score_state.dart';
import 'package:kai_schedule/repository/repository.dart';

import '../response_status_enum.dart';

class StudentScoreBloc extends Bloc<ScoreEvent, StudentScoreState> {
  final ApiRepository _apiRepository;
  StudentScoreBloc(this._apiRepository) : super(StudentScoreState()) {
    on<AuthCheckEvent>(authCheck);
    on<GetSemesterScoreEvent>(getStudentScore, transformer: restartable());
    on<AuthEvent>(authenticate, transformer: droppable());
    on<LogOutEvent>(logout);
  }
  Future<void> authCheck(event, Emitter<StudentScoreState> emit) async {
    final login = await _apiRepository.getLogin();
    final pass = await _apiRepository.getPass();
    final authStatus = login.isEmpty && pass.isEmpty
        ? AuthStatus.unauthorized
        : AuthStatus.authorized;
    if (authStatus == AuthStatus.authorized) {
      add(AuthEvent(login: login, pass: pass));
    } else {
      emit(state.copyWith(authStatus: AuthStatus.unauthorized));
    }
  }

  Future<void> authenticate(event, Emitter<StudentScoreState> emit) async {
    if (event.login.isEmpty || event.pass.isEmpty) return;
    try {
      emit(state.copyWith(responseStatus: ResponseStatus.success));
      final jsession = await _apiRepository.authenticate(
          login: event.login, pass: event.pass);
      final authStatus =
          jsession.isEmpty ? AuthStatus.unauthorized : AuthStatus.authorized;
      if (authStatus == AuthStatus.authorized) {
        _apiRepository.setLogin(event.login);
        _apiRepository.setPass(event.pass);
      }
      emit(state.copyWith(jsession: jsession, authStatus: authStatus));
    } catch (e) {
      emit(state.copyWith(
          responseStatus: ResponseStatus.failure,
          authStatus: AuthStatus.unauthorized));
    }
  }

  Future<void> logout(event, Emitter<StudentScoreState> emit) async {
    await _apiRepository.removeLoginAndPass();
    emit(state.copyWith(authStatus: AuthStatus.unauthorized));
  }

  Future<void> getStudentScore(event, Emitter<StudentScoreState> emit) async {
    try {
      emit(state.copyWith(isScoreUpdating: true));
      final scoreData = event.semester == null
          ? await _apiRepository.getScore(jsession: state.jsession)
          : await _apiRepository.getScore(
              jsession: state.jsession,
              authToken: state.authToken,
              semester: event.semester.toString());
      emit(state.copyWith(
          responseStatus: ResponseStatus.success,
          scoreData: scoreData['score'],
          authToken: scoreData['authToken'],
          jsession: scoreData['jsession'],
          semesters: scoreData['semesters'],
          isScoreUpdating: false));
    } catch (e) {
      emit(state.copyWith(
          responseStatus: ResponseStatus.failure, isScoreUpdating: false));
    }
  }
}
