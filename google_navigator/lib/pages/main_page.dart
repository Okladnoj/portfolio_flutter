import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_navigator/servises/get_distance.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _stringDistanseFoPlase = '';
  Set<Polyline> _polilines = {};
  Marker _markerChooseLocation = Marker(
    position: LatLng(0.0, 0.0),
    markerId: MarkerId('Choose Locaion'),
  );
  Marker _markerMyLocation = Marker(
    position: LatLng(0.0, 0.0),
    markerId: MarkerId('My Locaion'),
  );
  double _direction;
  BitmapDescriptor navigatorIcon;
  int _alfaChangeType = 70;
  int _alfaChoothLocation = 70;
  int _alfaTarget = 200;
  int _distanceToLocation = 0;
  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0.0, 0.0),
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
    _setCustomIcon(); //the app will be destroyed

    FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction;
      });
    });
  }

  void _fundistanceToLocation() {
    if (_currentLocation != null) {
      _distanceToLocation = GetDistance.getKm(locFirst: [
        _markerChooseLocation.position.latitude ?? 0,
        _markerChooseLocation.position.longitude ?? 0
      ], locSecond: [
        _currentLocation.latitude ?? 0,
        _currentLocation.longitude ?? 0
      ]).distance.toInt();
    } else {
      _distanceToLocation = 0;
    }
  }

  _setCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              devicePixelRatio: 1.0,
              locale: Locale.fromSubtags(),
            ),
            'assets/IconNavigatorM.png')
        .then((onValue) {
      navigatorIcon = onValue;
    });
  }

  Set<Marker> _locMark() {
    _markerMyLocation = Marker(
      position: LatLng(
        _currentLocation.latitude ?? 0.0,
        _currentLocation.longitude ?? 0.0,
      ),
      icon: navigatorIcon == null
          ? BitmapDescriptor.defaultMarker
          : navigatorIcon,
      markerId: MarkerId('My Locaion'),
      anchor: Offset(0.5, 0.65),
      rotation: _direction - 0 ?? 0,
    );
    _markers.clear();
    _markers.add(_markerMyLocation);
    if (_alfaChoothLocation > 70) _markers.add(_markerChooseLocation);
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    googleMap = GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      initialCameraPosition: _initialCamera ?? true,
      mapType: _currentMapType,
      markers: _locMark().isEmpty ? null : _markers,
      onCameraMove: _onCameraMove,
      compassEnabled: true,
      rotateGesturesEnabled: false,
      polylines: _polilines,
    );

    void polilinesShow() {
      Polyline _lineToPlace;
      if ((_alfaChoothLocation == 200) & (_polilines.isEmpty)) {
        _lineToPlace = Polyline(
          polylineId: PolylineId('11111'),
          points: [
            LatLng(_markerMyLocation.position.latitude,
                _markerMyLocation.position.longitude),
            LatLng(_markerChooseLocation.position.latitude,
                _markerChooseLocation.position.longitude)
          ],
          color: Colors.red.withAlpha(160),
          visible: true,
          width: 3,
        );
        setState(() {
          _polilines.add(_lineToPlace);
        });
      } else {
        setState(() {
          _polilines.clear();
        });
      }
    }

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
        _markerChooseLocation = Marker(
          markerId: MarkerId("New Location"),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'Current Plase',
            snippet: 'Count the distance to this',
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        if (_alfaChoothLocation > 70) {
          _markers.clear();
          _polilines.clear();
          _markers.add(_markerMyLocation);
          _alfaChoothLocation = 70;
          _alfaTarget = 200;
          _distanceToLocation = 0;
        } else {
          _markers.clear();
          _markers.add(_markerChooseLocation);
          _markers.add(_markerMyLocation);
          _alfaChoothLocation = 200;
          _alfaTarget = 0;
          _fundistanceToLocation();
        }
      });
      _stringDistance();
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
                  child: googleMap ??
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ));
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
            _rotwidget(),
            _buttomWidget(context),
          ]),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'calculate',
            onPressed: () {
              polilinesShow();
            },
            label: Text(_stringDistanseFoPlase),
            icon: Icon(Icons.linear_scale),
            backgroundColor: Colors.pink[900].withAlpha(150),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  Widget _rotwidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Container(
        height: 100,
        width: 100,
        alignment: Alignment.bottomLeft,
        color: Colors.white.withAlpha(0),
        child: new Transform.rotate(
          angle: ((_direction ?? 0) * (pi / 180) * -1),
          child: Center(
            child: Image.asset(
              'assets/IconCompas.png',
              scale: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  _stringDistance() {
    if (_distanceToLocation > 0) {
      if (_distanceToLocation > 1000) {
        double _d = _distanceToLocation / 1000;
        _stringDistanseFoPlase =
            'To this place ${_d.toStringAsFixed(2)} kilometers';
      } else {
        _stringDistanseFoPlase = 'To this place $_distanceToLocation meters';
      }
    } else {
      _stringDistanseFoPlase = 'Show distance on TAP';
    }
  }

  LatLng _lastMapPosition = _initialCamera.target;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 3000);

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
                target: LatLng(result.latitude, result.longitude), zoom: 18);

            if (mounted) {
              setState(() {
                _currentLocation = result;
                _stringDistance();
                _fundistanceToLocation();
              });
            }
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));
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
