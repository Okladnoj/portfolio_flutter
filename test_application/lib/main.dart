import 'package:flutter/material.dart';

import 'pages/page_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClasTest(),
    );
  }
}

class ClasTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text('String: $index');
        },
      ),
    );
  }
}

List<Widget> _myList = [
  Text('line1'),
  Divider(),
  Text('line1'),
  Divider(),
  Text('line1'),
  Divider(),
  Text('line1'),
  Divider(),
  Text('line1'),
  Divider(),
  Text('line1'),
  Divider(),
  Text('line1'),
  Divider(),
];
