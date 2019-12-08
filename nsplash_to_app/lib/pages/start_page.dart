import 'package:flutter/material.dart';
import 'package:nsplash_to_app/models/list_models.dart';
import 'package:nsplash_to_app/net/responce_json.dart';
import 'package:nsplash_to_app/pages/main_pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModelProvider = UserModelProvider();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<UserModels>(
            future: _userModelProvider.getCurrentUsersModes(),
            builder: (context, projectSnap) {
              if (projectSnap.hasData) {
                return UserModeslContainer(userModels: projectSnap.data);
              } else if (projectSnap.hasError) {
                return Text('${projectSnap.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
