import 'package:kai_schedule/api/api_client.dart';
import 'package:kai_schedule/models/lecturer_schedule.dart';
import 'package:kai_schedule/models/student_schedule.dart';

class ScheduleRepository {
  final ApiClient _apiClient;
  ScheduleRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();
  Future<bool> isEven() async {
    var d0 = DateTime.now().millisecondsSinceEpoch;
    var d = DateTime(DateTime.now().year, 1, 1);
    var d1 = d.millisecondsSinceEpoch;
    var re = (((d0 - d1) / 8.64e7) + (6)).floor();
    return ((re / 7).floor() % 2 == 0) ? true : false;
  }

  Future<List<List<List<Lesson>>>> getStudentScheduleByGroup(
      {required String group}) async {
    final schedule = await _apiClient.fetchStudentScheduleByGroup(group: group);
    final List<Lesson> evenList = [];
    final List<Lesson> oddList = [];
    final List<List<Lesson>> oddWeek = [];
    final List<List<Lesson>> evenWeek = [];
    final list = [
      schedule.l1,
      schedule.l2,
      schedule.l3,
      schedule.l4,
      schedule.l5,
      schedule.l6
    ];
    for (var day in list) {
      if (day != null) {
        for (var lesson in day) {
          if (lesson.dayDate.contains('/')) {
            evenList.add(lesson);
            oddList.add(lesson);
          } else if (lesson.dayDate.contains('неч')) {
            oddList.add(lesson);
          } else if (lesson.dayDate.contains('чет')) {
            evenList.add(lesson);
          } else {
            evenList.add(lesson);
            oddList.add(lesson);
          }
        }
        oddWeek.add([...oddList]);
        evenWeek.add([...evenList]);
        oddList.clear();
        evenList.clear();
      }
      else {
        oddWeek.add([...[]]);
        evenWeek.add([...[]]);
        oddList.clear();
        evenList.clear();
      }
    }
    final scheduleList = [oddWeek, evenWeek];
    return scheduleList;
  }

  Future<List<String>> getLecturersNamesList() async {
    final listOfLecturer = await _apiClient.fetchLecturersNamesList();
    return listOfLecturer;
  }

  Future<List<List<LecturerLesson>?>> getLecturerSchedule(String name) async {
    final schedule = await _apiClient.fetchLecturerSchedule(name);
    final list = [
      schedule.l1,
      schedule.l2,
      schedule.l3,
      schedule.l4,
      schedule.l5,
      schedule.l6,
    ];
    final List<LecturerLesson> dayScheduleList = [];
    final List<List<LecturerLesson>?> scheduleList = [];
    String previousTime = '';
    String previousDate = '';
    for (var day in list) {
      if (day != null) {
        dayScheduleList.clear();
        for (var lecture in day) {
          if (lecture.dayTime == previousTime &&
              lecture.dayDate == previousDate) {
            dayScheduleList.last.group += ', ${lecture.group}';
            continue;
          }
          previousDate = lecture.dayDate;
          previousTime = lecture.dayTime;
          dayScheduleList.add(lecture);
        }
        previousTime = '';
        previousDate = '';
        scheduleList.add([...dayScheduleList]);
      } else {
        scheduleList.add(day);
      }
    }
    return scheduleList;
  }
}
