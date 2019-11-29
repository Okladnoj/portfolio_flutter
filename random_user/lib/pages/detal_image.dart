import 'package:flutter/material.dart';
import 'package:random_user/calc/get_distanse.dart';
import 'package:random_user/models/user_model.dart';

class ImageDetalisPage extends StatelessWidget {
  final String assetPath;
  final UserModel userModel;
  final MyLocation myLocation;

  const ImageDetalisPage(
      {Key key, @required this.assetPath, this.userModel, this.myLocation})
      : assert(assetPath != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final int _dict = MyDist(userModel: userModel, myLocation: myLocation).km;
    return Scaffold(
      appBar: AppBar(
        title: Text('${userModel.titlename} ${userModel.lastname}'),
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          constraints: BoxConstraints.tightFor(height: 350, width: 350),
          child: Image.network(
            this.assetPath,
            fit: BoxFit.fill,
          ),
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            child: Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '${userModel.firstname} ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'age: ',
                ),
                TextSpan(
                    text: '${userModel.age}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              textScaleFactor: 2.5,
            )),
        Container(
            margin: const EdgeInsets.all(1.0),
            child: Text.rich(
                TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:
                          '${userModel.titlename} ${userModel.firstname} ${userModel.lastname} ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'lives in the country of ',
                  ),
                  TextSpan(
                      text: '${userModel.country}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: ', the city of ',
                  ),
                  TextSpan(
                      text: '${userModel.city},\n $_dict',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: ' km away from you.',
                  ),
                ]),
                textScaleFactor: 1.4,
                textAlign: TextAlign.center))
      ]),
    );
  }
}
