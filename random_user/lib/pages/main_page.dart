import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_user/appid/future_bild.dart';
import 'package:random_user/models/user_model.dart';
import 'package:random_user/pages/detal_image.dart';

class UserModelContainer extends StatelessWidget {
  final UserModel userModel;
  final MyLocation myLocation;

  UserModelContainer({
    Key key,
    this.userModel,
    this.myLocation,
  })  : assert(userModel != null),
        assert(myLocation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${userModel.titlename} ${userModel.lastname}'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(
                userModel.picture,
                scale: 1 / 2.5,
              ),
              Text(
                '${userModel.firstname} ${userModel.lastname}',
                textScaleFactor: 2.5,
                strutStyle: StrutStyle.disabled,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.values[5],
            crossAxisAlignment: CrossAxisAlignment.values[2],
            children: <Widget>[
              new FloatingActionButton(
                heroTag: 'Open',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageDetalisPage(
                              assetPath: userModel.picture,
                              userModel: userModel,
                              myLocation: myLocation)));
                },
                tooltip: 'Open',
                child: Icon(Icons.open_in_new),
              ),
              new FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  runApp(MyApp());
                },
                tooltip: 'Next',
                child: Icon(Icons.arrow_forward_ios),
              ),
            ]));
  }
}
