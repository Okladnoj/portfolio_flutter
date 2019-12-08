import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nsplash_to_app/models/list_models.dart';

class UserModelProvider {
  static final _apikey =
      "ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9";
  final _string = 'http://api.unsplash.com/photos/?client_id=$_apikey';
  Future<UserModels> getCurrentUsersModes() async {
    final http.Response response = await http.get(_string);
    if (response.statusCode == 200) {
      return UserModels.fromList(json.decode(response.body));
    } else {
      throw Exception('Failed to load UserModes data');
    }
  }
}
