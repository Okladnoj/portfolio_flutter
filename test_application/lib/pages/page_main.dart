import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_application/model/model_text.dart';

import 'arlet_change_text.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _tapcount = 0;
  Color _colorbackground;
  Color _colortext;
  ModelText modelText;

  void _cangeColor() {
    final _intrand = Random();
    final _maxint = 255;
    final _a = _maxint;
    final _r = _intrand.nextInt(_maxint);
    final _g = _intrand.nextInt(_maxint);
    final _b = _intrand.nextInt(_maxint);
    _colorbackground = Color.fromARGB(_a, _r, _g, _b);
    _colortext = Color.fromARGB(_a, _maxint - _r, _maxint - _g, _maxint - _b);
    _tapcount++;
  }

  AnimationController _controller;
  @override
  void initState() {
    modelText = ModelText();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 777),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Container(
            color: _colorbackground,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: Text(
                    modelText.texthey,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _colortext,
                        fontSize: 33,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            setState(
              () {
                _cangeColor();
                _tapcount % 2 == 1 ? _controller.repeat() : _controller.stop();
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(3.0),
            child: FloatingActionButton.extended(
              onPressed: () {},
              heroTag: 'counter',
              tooltip: 'Show number of tap',
              icon: Icon(Icons.touch_app),
              label: Text(
                '$_tapcount',
                style: TextStyle(
                    color: _colorbackground,
                    fontSize: 40,
                    fontWeight: FontWeight.w800),
              ),
              backgroundColor: _colortext,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(3.0),
                child: FloatingActionButton.extended(
                  onPressed: () => setState(
                    () {
                      cangeText(context: context, modelText: modelText);
                    },
                  ),
                  heroTag: 'change',
                  tooltip: 'Change text',
                  icon: Icon(Icons.repeat),
                  label: Text('CHANGE'),
                  backgroundColor: Colors.pink[800],
                ),
              ),
              Container(
                padding: EdgeInsets.all(3.0),
                child: FloatingActionButton.extended(
                  onPressed: () => setState(() {
                    _tapcount = 0;
                    _controller.reset();
                  }),
                  heroTag: 'reset',
                  tooltip: 'Reset tap progres',
                  icon: Icon(Icons.settings_backup_restore),
                  label: Text('RESET'),
                  backgroundColor: Colors.pink[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
