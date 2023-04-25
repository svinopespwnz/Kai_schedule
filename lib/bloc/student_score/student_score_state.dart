import 'package:kai_schedule/bloc/auth_status_enum.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';

class StudentScoreState {
  final ResponseStatus responseStatus;
  final AuthStatus authStatus;
  final List<List<String>> scoreData;
  final int semesters;
  final String authToken;
  final String jsession;
  final bool isScoreUpdating;

  StudentScoreState({
    this.responseStatus = ResponseStatus.success,
    this.authStatus = AuthStatus.unknown,
    this.semesters = 1,
    this.authToken = '',
    this.jsession = '',
    this.isScoreUpdating = false,
    List<List<String>>? scoreData,
  }) : scoreData = scoreData ?? [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentScoreState &&
          runtimeType == other.runtimeType &&
          responseStatus == other.responseStatus &&
          authStatus == other.authStatus &&
          scoreData == other.scoreData &&
          semesters == other.semesters &&
          authToken == other.authToken &&
          isScoreUpdating == other.isScoreUpdating &&
          jsession == other.jsession;

  @override
  int get hashCode =>
      responseStatus.hashCode ^
      authStatus.hashCode ^
      scoreData.hashCode ^
      semesters.hashCode ^
      authToken.hashCode ^
      isScoreUpdating.hashCode ^
      jsession.hashCode;

  StudentScoreState copyWith({
    ResponseStatus? responseStatus,
    AuthStatus? authStatus,
    List<List<String>>? scoreData,
    int? semesters,
    String? authToken,
    bool? isScoreUpdating,
    String? jsession,
  }) {
    return StudentScoreState(
      responseStatus: responseStatus ?? this.responseStatus,
      authStatus: authStatus ?? this.authStatus,
      scoreData: scoreData ?? this.scoreData,
      semesters: semesters ?? this.semesters,
      authToken: authToken ?? this.authToken,
      isScoreUpdating: isScoreUpdating ?? this.isScoreUpdating,
      jsession: jsession ?? this.jsession,
    );
  }
}
