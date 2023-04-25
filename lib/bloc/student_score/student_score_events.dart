abstract class ScoreEvent {}

class GetSemesterScoreEvent extends ScoreEvent {
  GetSemesterScoreEvent({this.semester});
  final int? semester;
}

class AuthCheckEvent extends ScoreEvent {}

class LogOutEvent extends ScoreEvent {}

class AuthEvent extends ScoreEvent {
  AuthEvent({required this.login, required this.pass});
  final String login;
  final String pass;
}
