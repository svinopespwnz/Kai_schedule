import 'package:kai_schedule/api/api_client.dart';
import 'package:kai_schedule/models/models.dart';

class ScheduleRepository {
  final ApiClient _apiClient;
  ScheduleRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();
  Future<bool> isEven() async {
    var d0 = DateTime(2022,8,7).millisecondsSinceEpoch;
    var d = DateTime(DateTime.now().year, 1, 1);
    var d1 = d.millisecondsSinceEpoch;
    var dd = d.day;
    var re = (((d0 - d1) / 8.64e7) + ( 6)).floor();
   return ((re/7).floor() % 2==0) ? true : false ;
  }

  Future<List<List<Lesson>>> getSchedule(
      {required String group, required bool isEven}) async {
    final schedule = await _apiClient.apiRequestByGroup(group: group);
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
    return isEven ? evenWeek : oddWeek;
  }
}
