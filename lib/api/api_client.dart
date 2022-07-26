import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kai_schedule/models/lecturer_schedule.dart';
import 'package:kai_schedule/models/student_schedule.dart';


class ApiClient {
  Future<Schedule> apiRequestByGroup({required String group}) async {
    final qParams = {
      "p_p_id": "pubStudentSchedule_WAR_publicStudentSchedule10",
      "p_p_lifecycle": "2",
      "p_p_resource_id": "getGroupsURL",
      "query": group
    };

    final url = Uri.parse('https://kai.ru/raspisanie')
        .replace(queryParameters: qParams);
    final response = (await http.get(url));
    final groupId = (jsonDecode(response.body)).first["id"].toString();

    final params = {
      "p_p_id": "pubStudentSchedule_WAR_publicStudentSchedule10",
      "p_p_lifecycle": "2",
      "p_p_resource_id": "schedule",
      "groupId": groupId
    };
    final url2 =
        Uri.parse('https://kai.ru/raspisanie').replace(queryParameters: params);

    final response2 = await http.get(url2);
    final json = (jsonDecode(response2.body));
    return Schedule.fromJson(json);
  }

  Future<List<dynamic>> getLecturers() async {
    final params = {
      "p_p_id": "pubLecturerSchedule_WAR_publicLecturerSchedule10",
      "p_p_lifecycle": "2",
      "p_p_resource_id": "getLecturersURL",
      "query": "_"
    };
    final url = Uri.parse("https://kai.ru/for-staff/raspisanie")
        .replace(queryParameters: params);

    final response = (await http.get(url));

    final lecturers = jsonDecode(response.body) as List;
    return lecturers;
  }

  Future<List<dynamic>> getLecturersNamesList() async {
    final lecturers= await getLecturers();
    List listOfLecturer = [];
     for (var element in lecturers) {
       listOfLecturer.add(element['lecturer']);
     }
     return listOfLecturer ;
  }
  Future<LecturerSchedule> getLecturerSchedule(String name) async{
    final lecturers= await getLecturers();
    final lecturer = lecturers.firstWhere(
              (element) => element.values.contains(name));
    final id=lecturer['id'];
    final params = {
         "p_p_id": "pubLecturerSchedule_WAR_publicLecturerSchedule10",
         "p_p_lifecycle": "2",
         "p_p_resource_id": 'schedule',
         "prepodLogin": id
       };
       final url = Uri.parse("https://kai.ru/for-staff/raspisanie")
           .replace(queryParameters: params);
       final response = (await http.get(url));
       final json=jsonDecode(response.body);
       return LecturerSchedule.fromJson(json);
  }


}
