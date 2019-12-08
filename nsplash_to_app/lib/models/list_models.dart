import 'package:nsplash_to_app/models/user_model.dart';

import 'user_model.dart';

class UserModels {
  final List<UserModel> userModels;
  const UserModels({this.userModels});

  factory UserModels.fromList(List<dynamic> json) {
    return UserModels(userModels: _getuserModels(json));
  }

  static _getuserModels(List<dynamic> json) {
    List<UserModel> _userModels = List();
    for (int _i = 0; _i < json.length; _i++) {
      _userModels.add(UserModel.fromJson(i: _i, json: json));
    }
    return _userModels;
  }
}
