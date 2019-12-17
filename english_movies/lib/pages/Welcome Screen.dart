import 'package:flutter/material.dart';

import '../main.dart';
import 'dart:math' as math;

class WelcomeScreen extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00fff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Movie ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0603,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  'Free',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0603,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: CustomPaint(
                    size: Size(100, 100),
                    painter: MyPainter(),
                  ),
                )
              ],
            ),
            Text(
              '111',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(-30, 0, 30, 90); //38.03 76.06
    final startAngle = -math.pi / 2;
    final sweepAngle = math.pi;
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }
}
