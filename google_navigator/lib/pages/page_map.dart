import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';

class MapPageState extends State<MapPage> {
  GoogleMapController mapController;

  final LatLng _centr = const LatLng(45.00, 39.00);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _centr,
                  zoom: 11.0,
                ),
              ),
            ),
            Text('data'),
          ],
        ),
      ),
    );
  }
}
