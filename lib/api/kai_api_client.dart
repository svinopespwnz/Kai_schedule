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

  // Future<String> authenticate() async {
  //   final url = Uri.parse("https://cas.kai.ru:8443/cas/login");
  //   final response = (await http.get(url));
  //   final document = parse(response.body);
  //   final token = document
  //       .getElementsByTagName('input')
  //       .firstWhere((element) => element.attributes['name'] == 'lt')
  //       .attributes['value'];
  //
  //   final qp = {
  //     "username": 'PantsyrevRI',
  //     "password": 'efjm6zud',
  //     "execution": "e1s1",
  //     "_eventId": "submit",
  //     "lt": token
  //   };
  //   final cookieLength = response.headers['set-cookie']!.indexOf(';');
  //   final cookie = response.headers['set-cookie']!.substring(0, cookieLength);
  //   final url2 = Uri.parse("https://cas.kai.ru:8443/cas/login")
  //       .replace(queryParameters: qp);
  //   final post = await http.post(url2, headers: {"Cookie": cookie});
  //   final tokenCASTGCst = post.headers['set-cookie']!.indexOf('CASTGC');
  //   final tokenCASTGCend =
  //       post.headers['set-cookie']!.indexOf('; Path=/cas/; Secure');
  //   final tokenCASTGC =
  //       post.headers['set-cookie']!.substring(tokenCASTGCst, tokenCASTGCend);
  //   final url3 = Uri.parse(
  //       "https://cas.kai.ru:8443/cas/login?service=https://kai.ru/c/portal/login");
  //   final response3 = await http.get(url3, headers: {"Cookie": tokenCASTGC});
  //   final doc = parse(response3.body);
  //   final brscookie = response3.headers[
  //       'set-cookie']!; //.substring(0, brscookie.indexOf('; Path=/; Secure'));
  //   final brscookieend = brscookie.substring(0, brscookie.indexOf('; '));
  //
  //   final qp2 = {
  //     'p_p_id': '58',
  //     'p_p_lifecycle': '0',
  //     'p_p_state': 'maximized',
  //     'p_p_mode': 'view',
  //     '_58_struts_action': '/login/login',
  //     '_58_formDate': '668599414964',
  //     '_58_saveLastPath': 'false',
  //     '_58_redirect': '',
  //     '_58_doActionAfterLogin': 'false',
  //     '_58_login': 'pantsyrevri',
  //     '_58_password': 'efjm6zud'
  //   };
  //   final url4 = Uri.parse(
  //       'https://kai.ru/main?p_p_id=58&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&saveLastPath=false&_58_struts_action=%2Flogin%2Flogin&_58_formDate=1668698405169&_58_saveLastPath=false&_58_redirect=&_58_doActionAfterLogin=false&_58_login=pantsyrevri&_58_password=efjm6zud');
  //   //  .replace(queryParameters: qp2);
  //   final response4 = await http.post(url4);
  //   final a = response4.body;
  //
  //   final cookiesend = response4.headers['set-cookie']!.indexOf('; ');
  //   final cookief = response4.headers['set-cookie']!.substring(0, cookiesend);
  //   final url5 = Uri.parse('https://kai.ru/main').replace(queryParameters: qp2);
  //   final response5 = await http.post(url5,headers: {"Cookie":cookief});
  //   final cookies = response5.headers['set-cookie'];
  //   final bod=response5.body;
  //   return cookief;
  // }
  //
  // Future<void> getScore({String? authToken, String? jsession}) async {
  //   jsession ??= await authenticate();
  //   final brsurl =
  //       Uri.parse("https://kai.ru/group/guest/student/attestacia").replace(
  //           queryParameters: authToken == null
  //               ? {}
  //               : {
  //                   "p_auth": authToken,
  //                   "p_p_id": "myBRS_WAR_myBRS10",
  //                   "p_p_lifecycle": "1",
  //                   "p_p_state": "normal",
  //                   "p_p_mode": "view",
  //                   "p_p_col_id": "column-2",
  //                   "p_p_col_count": "1",
  //                   "_myBRS_WAR_myBRS10_javax.portlet.action": "selectSemester",
  //                   "semester": "6"
  //                 });
  //   final response4 = await http.get(brsurl,
  //       headers: {"Cookie": jsession}).timeout(Duration(seconds: 12));
  //   final a = response4.body;
  //   if (authToken == null) {
  //     final authTokenStart = response4.body.indexOf("Liferay.authToken = '") +
  //         "Liferay.authToken = '".length;
  //     final authTokenEnd = authTokenStart + 8;
  //     final authTokenResponse =
  //         response4.body.substring(authTokenStart, authTokenEnd);
  //     final res =
  //         await getScore(authToken: authTokenResponse, jsession: jsession);
  //   } else {
  //     final b = response4.body;
  //   }
  // }
}
