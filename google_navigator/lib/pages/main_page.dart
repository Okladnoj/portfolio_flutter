import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _alfaChangeType = 70;
  int _alfaChoothLocation = 70;
  int _alfaTarget = 200;
  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  CameraPosition _currentCameraPosition;
  Set<Marker> _markers = {};

  GoogleMap googleMap;
  MapType _currentMapType = MapType.normal;
  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    googleMap = GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      initialCameraPosition: _initialCamera,
      mapType: _currentMapType,
      myLocationEnabled: true,
      markers: _markers,
      onCameraMove: _onCameraMove,
    );
    void _onMapTypeButtonPressed() {
      setState(() {
        _currentMapType = _currentMapType == MapType.normal
            ? MapType.satellite
            : MapType.normal;
        _alfaChangeType = _currentMapType == MapType.normal ? 150 : 70;
      });
    }

    void _onAddMarkerButtonPressed() {
      setState(() {
        var _itemLoc = Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: 'count the distance to this',
          ),
          icon: BitmapDescriptor.defaultMarker,
        );
        if (_markers.length != 0) {
          _markers.clear();
          _alfaChoothLocation = 70;
          _alfaTarget = 200;
        } else {
          _markers.add(_itemLoc);
          _alfaChoothLocation = 200;
          _alfaTarget = 0;
        }
      });
    }

    Widget _widget() {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Center(
            child: LayoutBuilder(builder: (context, costraints) {
              return SizedBox(
                  height: costraints.constrainHeight(),
                  width: costraints.constrainWidth(),
                  child: googleMap);
            }),
          ),
          Icon(
            Icons.center_focus_weak,
            size: 60,
            color: Colors.green.withAlpha(_alfaTarget),
          ),
        ],
      );
    }

    Widget _buttomWidget(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                  onPressed: () => _onMapTypeButtonPressed(),
                  tooltip: 'Change the map’s appearance',
                  backgroundColor: Colors.redAccent.withAlpha(_alfaChangeType),
                  child: Icon(
                    Icons.map,
                    size: 45.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                  onPressed: () => _onAddMarkerButtonPressed(),
                  tooltip: 'Add a marker to the map',
                  backgroundColor: Colors.green.withAlpha(_alfaChoothLocation),
                  child: Icon(
                    Icons.add_location,
                    size: 55.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: new Scaffold(
          appBar: new AppBar(
              title: new Center(
            child: new Text('Google Maps for Flutter'),
          )),
          body: new Stack(children: <Widget>[
            _widget(),
            _buttomWidget(context),
          ]),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'calculate',
            onPressed: () {},
            label: Text('Calculate'),
            icon: Icon(Icons.linear_scale),
            backgroundColor: Colors.pink[900].withAlpha(150),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  LatLng _lastMapPosition = _initialCamera.target;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 10000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));

            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }
}
