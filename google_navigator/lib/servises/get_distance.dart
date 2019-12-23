import 'package:latlong/latlong.dart';

class GetDistance {
  static Distance dist = new Distance();
  final double distance;
  GetDistance({this.distance});
  factory GetDistance.getKm({List<double> locFirst, List<double> locSecond}) {
    return GetDistance(
      distance: dist(new LatLng(locFirst[0], locFirst[1]),
          new LatLng(locSecond[0], locSecond[1])),
    );
  }
}
