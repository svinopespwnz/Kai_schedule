import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:kai_schedule/models/lecturer_schedule.dart';
import 'package:kai_schedule/models/student_schedule.dart';

class ApiClient {
  ApiClient._privateConstructor();
  static final ApiClient _instance = ApiClient._privateConstructor();

  factory ApiClient() {
    return _instance;
  }
  Future<Schedule> fetchStudentScheduleByGroup({required String group}) async {
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

  Future<List<dynamic>> fetchLecturers() async {
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

  Future<List<dynamic>> fetchLecturersNamesList() async {
    final lecturers = await fetchLecturers();
    List listOfLecturer = [];
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
    final params = {
      "p_p_id": "pubLecturerSchedule_WAR_publicLecturerSchedule10",
      "p_p_lifecycle": "2",
      "p_p_resource_id": 'schedule',
      "prepodLogin": id
    };
    final url = Uri.parse("https://kai.ru/for-staff/raspisanie")
        .replace(queryParameters: params);
    final response = (await http.get(url));
    final json = jsonDecode(response.body);
    return LecturerSchedule.fromJson(json);
  }

  Future<String> authenticate() async {
    final url = Uri.parse("https://cas.kai.ru:8443/cas/login");
    final response = (await http.get(url));
    final document = parse(response.body);
    final token = document
        .getElementsByTagName('input')
        .firstWhere((element) => element.attributes['name'] == 'lt')
        .attributes['value'];

    final qp = {
      "username": 'PantsyrevRi',
      "password": 'efjm6zud',
      "execution": "e1s1",
      "_eventId": "submit",
      "lt": token
    };
    //  final cookieLength = response.headers['set-cookie']!.indexOf(';');
    final cookie =
        response.headers['set-cookie']!; //.substring(0, cookieLength);
    final url2 = Uri.parse("https://cas.kai.ru:8443/cas/login")
        .replace(queryParameters: qp);
    final post = await http.post(url2, headers: {"Cookie": cookie});
    final tokenCASTGCst = post.headers['set-cookie']!.indexOf('CASTGC');
    final tokenCASTGCend =
        post.headers['set-cookie']!.indexOf('; Path=/cas/; Secure');
    final tokenCASTGC =
        post.headers['set-cookie']!.substring(tokenCASTGCst, tokenCASTGCend);
    final url3 = Uri.parse(
        "https://cas.kai.ru:8443/cas/login?service=https://kai.ru/c/portal/login");
    final response3 = await http.get(url3, headers: {"Cookie": tokenCASTGC});
    final brscookie =
        response3.headers['set-cookie']!; //.substring(0, brscookieLength);

    return brscookie;

  }

  Future<void> getScore({String? authToken, String? jsession}) async {
    jsession ??= await authenticate();
    final brsurl =
        Uri.parse("https://kai.ru/group/guest/student/attestacia").replace(
            queryParameters: authToken == null
                ? {}
                : {
                    "p_auth": authToken,
                    "p_p_id": "myBRS_WAR_myBRS10",
                    "p_p_lifecycle": '1',
                    "p_p_state": "normal",
                    "p_p_mode": "view",
                    "p_p_col_id": "column-2",
                    "p_p_col_count": '1',
                    "_myBRS_WAR_myBRS10_javax.portlet.action": "selectSemester",
                    "semester": '6'
                  });
    final response4 = await http.get(brsurl, headers: {"Cookie": jsession});
    final authTokenStart = response4.body.indexOf("Liferay.authToken = '") +
        "Liferay.authToken = '".length;
    final authTokenEnd = authTokenStart + 8;
    final authTokenResponse = response4.body.substring(authTokenStart, authTokenEnd);
    await getScore(authToken: authTokenResponse, jsession: jsession);

  }
}
