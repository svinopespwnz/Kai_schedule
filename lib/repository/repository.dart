import 'package:kai_schedule/api/kai_api_client.dart';
import 'package:kai_schedule/models/lecturer_schedule.dart';
import 'package:kai_schedule/models/student_schedule.dart';
import 'package:kai_schedule/models/wall_post.dart';

import '../api/vk_api_client.dart';
import '../local_data_provider/local_data_provider.dart';

class ApiRepository {
  final KaiApiClient _kaiApiClient;
  final VkApiClient _vkApiClient;
  final IDataBase _dataBase;
  ApiRepository(
      {KaiApiClient? apiClient, VkApiClient? vkApiClient, IDataBase? dataBase})
      : _kaiApiClient = apiClient ?? KaiApiClient(),
        _vkApiClient = vkApiClient ?? VkApiClient(),
        _dataBase = dataBase ?? LocalDataProvider();

  // Future<bool> isEven() async {
  //   var d0 = DateTime.now().millisecondsSinceEpoch;
  //   var d = DateTime(DateTime.now().year, 1, 1);
  //   var d1 = d.millisecondsSinceEpoch;
  //   var re = (((d0 - d1) / 8.64e7) + (6)).floor();
  //   return ((re / 7).floor() % 2 == 0) ? true : false;
  // }

  Future<List<List<List<Lesson>>>> getStudentScheduleByGroup(
      {required String group}) async {
    final schedule =
        await _kaiApiClient.fetchStudentScheduleByGroup(group: group);
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
      } else {
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
    final listOfLecturer = await _kaiApiClient.fetchLecturersNamesList();
    return listOfLecturer;
  }

  Future<List<List<LecturerLesson>?>> getLecturerSchedule(String name) async {
    final schedule = await _kaiApiClient.fetchLecturerSchedule(name);
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

  Future<String> getLogin() async {
    await _dataBase.init();
    final login = _dataBase.get('login', '');
    return login;
  }

  Future<String> getPass() async {
    final pass = _dataBase.get('pass', '');
    return pass;
  }

  Future<void> setLogin<T>(T value) async {
    _dataBase.set('login', value);
  }

  Future<void> setPass<T>(T value) async {
    _dataBase.set('pass', value);
  }

  Future<void> removeLoginAndPass() async {
    _dataBase.remove('login');
    _dataBase.remove('pass');
  }

  Future<String> authenticate(
      {required String login, required String pass}) async {
    final jsession = await _kaiApiClient.authenticate(login: login, pass: pass);
    return jsession;
  }

  Future<Map<String, dynamic>> getScore(
      {required String jsession,
      String authToken = '',
      String semester = ''}) async {
    final scoreData = await _kaiApiClient.fetchScore(
        authToken: authToken, jsession: jsession, semester: semester);
    return scoreData;
  }

  Future<WallPost> getWall([int startIndex = 0]) async {
    final wall = await _vkApiClient.getWall(startIndex);
    return wall;
  }
}
