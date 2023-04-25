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
    } catch (e) {
      rethrow;
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
    } catch (e) {
      rethrow;
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
    } catch (e) {
      rethrow;
    }
  }

  Future<String> authenticate(
      {required String login, required String pass}) async {
    const url =
        "https://kai.ru/main?p_p_id=58&p_p_lifecycle=1&p_p_state=normal&p_p_mode=view&_58_struts_action=%2Flogin%2Flogin";
    Uri loginUrl = Uri.parse(url);
    const cookie =
        'COOKIE_SUPPORT=true; GUEST_LANGUAGE_ID=ru_RU; p1="oc/z+3gtX+huQp2ZM6nidw=="; p2="JQbXodq7MH/dPcB0RqJAqQ=="';
    final body = {
      '_58_formDate': '${DateTime.now().millisecondsSinceEpoch}',
      '_58_saveLastPath': 'false',
      '_58_redirect': '',
      '_58_doActionAfterLogin': 'false',
      '_58_login': login,
      '_58_password': pass
    };
    try {
      final postForCookies =
          await http.post(loginUrl, headers: {'Cookie': cookie}, body: body);
      final responseCookies = postForCookies.headers['set-cookie']!;
      if (!responseCookies.contains('USER_UUID')) {
        throw ApiClientException();
      }
      final authenticatePost = await http.post(loginUrl,
          headers: {'Cookie': cookie + responseCookies}, body: body);
      final authCookies = authenticatePost.headers['set-cookie'];
      return authCookies ?? '';
    } catch (e) {
      throw ApiClientException();
    }
  }

  Future<Map<String, dynamic>> fetchScore(
      {required String jsession,
      String authToken = '',
      String semester = ''}) async {
    final scoreUrl =
        Uri.parse("https://kai.ru/group/guest/student/attestacia").replace(
            queryParameters: authToken == ''
                ? {}
                : {
                    "p_auth": authToken,
                    "p_p_id": "myBRS_WAR_myBRS10",
                    "p_p_lifecycle": "1",
                    "p_p_state": "normal",
                    "p_p_mode": "view",
                    "p_p_col_id": "column-2",
                    "p_p_col_count": "1",
                    "_myBRS_WAR_myBRS10_javax.portlet.action": "selectSemester",
                    "semester": semester
                  });
    try {
      final scoreResponse =
          await http.get(scoreUrl, headers: {"Cookie": jsession});
      final scoreDataPage = parse(scoreResponse.body);
      final semesterSelector =
          scoreDataPage.getElementById('_myBRS_WAR_myBRS10_semester_0');
      final List<String> semesters = [];
      semesterSelector!.getElementsByTagName('option').forEach((element) {
        semesters.add(element.attributes['value']!);
      });
      final scoreTable = scoreDataPage
          .getElementsByClassName('table table-striped table-bordered')
          .first;
      final scoreTableData = scoreTable
          .getElementsByTagName('tr')
          .map((e) => e.getElementsByTagName('td').map((e) => e.text).toList())
          .where((element) => element.isNotEmpty)
          .toList();
      final authTokenStart =
          scoreResponse.body.indexOf("Liferay.authToken = '") +
              "Liferay.authToken = '".length;
      final authTokenEnd = authTokenStart + 8;
      authToken = scoreResponse.body.substring(authTokenStart, authTokenEnd);
      return {
        'authToken': authToken,
        'jsession': jsession,
        'semesters': semesters.length,
        'score': scoreTableData
      };
    } catch (e) {
      throw ApiClientException();
    }
  }
}
