import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kai_schedule/models/lecturer_schedule.dart';
import 'package:kai_schedule/models/student_schedule.dart';
import 'package:kai_schedule/utility/exceptions.dart';
import 'package:html/parser.dart' show parse;

class KaiApiClient {
  Future<Schedule> fetchStudentScheduleByGroup({required String group}) async {
    try {
      final queryParamsForGroupId = {
        "p_p_id": "pubStudentSchedule_WAR_publicStudentSchedule10",
        "p_p_lifecycle": "2",
        "p_p_resource_id": "getGroupsURL",
        "query": group
      };

      final urlGroupId = Uri.parse('https://kai.ru/raspisanie')
          .replace(queryParameters: queryParamsForGroupId);

      final groupIdResponse =
          await http.get(urlGroupId).timeout(const Duration(seconds: 12));

      if (groupIdResponse.statusCode == 200) {
        final json = jsonDecode(groupIdResponse.body);
        if (json.isEmpty) throw GroupDoesntExistException();
        final groupId = (json).first["id"].toString();

        final queryParamsForSchedule = {
          "p_p_id": "pubStudentSchedule_WAR_publicStudentSchedule10",
          "p_p_lifecycle": "2",
          "p_p_resource_id": "schedule",
          "groupId": groupId
        };
        final urlGroupSchedule = Uri.parse('https://kai.ru/raspisanie')
            .replace(queryParameters: queryParamsForSchedule);

        final groupScheduleResponse = await http
            .get(urlGroupSchedule)
            .timeout(const Duration(seconds: 12));
        if (groupScheduleResponse.statusCode == 200) {
          final json = (jsonDecode(groupScheduleResponse.body));
          return Schedule.fromJson(json);
        } else {
          throw ApiClientException();
        }
      } else {
        throw ApiClientException();
      }
    } on TimeoutException {
      throw ApiClientException();
    } on SocketException {
      throw ApiClientException();
    }
  }

  Future<List<dynamic>> fetchLecturers() async {
    try {
      final params = {
        "p_p_id": "pubLecturerSchedule_WAR_publicLecturerSchedule10",
        "p_p_lifecycle": "2",
        "p_p_resource_id": "getLecturersURL",
        "query": "_"
      };
      final url = Uri.parse("https://kai.ru/for-staff/raspisanie")
          .replace(queryParameters: params);

      final response = await http.get(url).timeout(const Duration(seconds: 12));
      if (response.statusCode == 200) {
        try {
          final lecturers = jsonDecode(response.body) as List;
          return lecturers;
        } on Exception {
          throw ApiClientException();
        }
      } else {
        throw ApiClientException();
      }
    } on TimeoutException {
      throw ApiClientException();
    } on SocketException {
      throw ApiClientException();
    }
  }

  Future<List<String>> fetchLecturersNamesList() async {
    final lecturers = await fetchLecturers();
    List<String> listOfLecturer = [];
    for (var element in lecturers) {
      listOfLecturer.add(element['lecturer']);
    }
    return listOfLecturer;
  }

  Future<LecturerSchedule> fetchLecturerSchedule(String name) async {
    final lecturers = await fetchLecturers();
    final lecturer =
        lecturers.firstWhere((element) => element.values.contains(name));
    final id = lecturer['id'];
    try {
      final params = {
        "p_p_id": "pubLecturerSchedule_WAR_publicLecturerSchedule10",
        "p_p_lifecycle": "2",
        "p_p_resource_id": 'schedule',
        "prepodLogin": id
      };
      final url = Uri.parse("https://kai.ru/for-staff/raspisanie")
          .replace(queryParameters: params);
      final response = await http.get(url).timeout(const Duration(seconds: 12));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return LecturerSchedule.fromJson(json);
      } else {
        throw ApiClientException();
      }
    } on TimeoutException {
      throw ApiClientException();
    } on SocketException {
      throw ApiClientException();
    }
  }

 
}
