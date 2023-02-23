import 'dart:convert';
import 'dart:io';
import 'package:kai_schedule/models/wall_post.dart';
import 'package:kai_schedule/utility/exceptions.dart';
import 'package:kai_schedule/utility/vk_access_token.dart';
import 'package:http/http.dart' as http;

class VkApiClient {
  Future<WallPost> getWall([int startIndex=0]) async {
    try {
      final queryParams = {
        'count':'20',
        'owner_id': '-406973',
        'filter': 'owner',
        'offset': '$startIndex',
        'access_token': vktoken,
        'v': '5.131'
      };
      final vkUrl = Uri.parse('https://api.vk.com/method/wall.get')
          .replace(queryParameters: queryParams);
      final vkResponse = await http.get(vkUrl).timeout(const Duration(seconds: 12));
      final json = jsonDecode(vkResponse.body);
      return WallPost.fromJson(json);
    } on SocketException {
      throw ApiClientException();
    }
  }
}
