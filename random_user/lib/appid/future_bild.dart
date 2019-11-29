import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../net/responce_json.dart';
import '../pages/main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModelProvider = UserModelProvider();
    final _myLocationProvider = MyLocationProvider();
    return MaterialApp(
      title: 'Random User',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(
            child: FutureBuilder<UserModel>(
          future: _userModelProvider.getCurrentUserMode(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new MaterialApp(
                title: 'Random User',
                theme: ThemeData(primarySwatch: Colors.blue),
                home: Scaffold(
                  body: Center(
                      child: FutureBuilder<MyLocation>(
                    future: _myLocationProvider.getCurrentMyLocation(),
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData) {
                        return new UserModelContainer(
                            userModel: snapshot.data,
                            myLocation: snapshot1.data);
                      } else if (snapshot1.hasError) {
                        return Text('${snapshot1.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}
