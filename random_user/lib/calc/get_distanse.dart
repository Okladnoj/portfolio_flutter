import 'package:latlong/latlong.dart';
import 'package:random_user/models/user_model.dart';

class MyDist {
  int km;
  static Distance distance = new Distance();
  static var myXY = <double>[];
  static var userXY = <double>[];
  MyDist({UserModel userModel, MyLocation myLocation}) {
    userXY = [
      double.parse(userModel.latitude),
      double.parse(userModel.longitude)
    ];
    myXY = [
      double.parse(myLocation.latitude),
      double.parse(myLocation.longitude)
    ];
    double km = ((distance(
            new LatLng(userXY[0], userXY[1]), new LatLng(myXY[0], myXY[1]))) /
        1000.0);
    this.km = km.toInt();
  }
}
