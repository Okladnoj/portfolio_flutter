import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_user/models/user_model.dart';

class UserModelProvider {
  final String _string = 'https://randomuser.me/api/';
  Future<UserModel> getCurrentUserMode() async {
    final http.Response response = await http.get(_string);
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load UserMode data');
    }
  }
}

class MyLocationProvider {
  final String _string = 'http://free.ipwhois.io/json/';
  Future<MyLocation> getCurrentMyLocation() async {
    final http.Response response = await http.get(_string);
    if (response.statusCode == 200) {
      return MyLocation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load MyLocation data');
    }
  }
}
