import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kai_schedule/models/models.dart';
import 'package:html/parser.dart' show parse;

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

  Future<String> isEvenWeekApiRequest() async {
    final url = Uri.parse('https://kai.ru/main');
    final response = await http.get(url);
    final document = parse(response.body);
    print(document);
//     final even = document.getElementsByClassName('week_parity')[0].children[0];
// print(even.toString());
    return 'isEven';
  }
}
