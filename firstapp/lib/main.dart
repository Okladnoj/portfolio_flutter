import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(),
        body: new NewsBox('Новый урок по Flutter',
            'В новом уроке рассказывается в каких случаях применять класс StatelessWidget и StatefulWidget. Приведены примеры их использования.',
            imagerul: ''),
      ),
    );
  }
}

class NewsBox extends StatelessWidget {
  final String _title;
  final String _text;
  String _imagerul;
  NewsBox(this._title, this._text, {String imagerul}) {
    _imagerul = imagerul;
  }

  @override
  Widget build(BuildContext context) {
    if (_imagerul != null && _imagerul != '')
      return Container(
        height: 100.0,
        color: Colors.black12,
        child: Row(
          children: <Widget>[
            new Image.network(
              _imagerul,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(0.5),
                child: new Column(
                  children: <Widget>[
                    new Text(
                      _title + _title,
                      style: new TextStyle(fontSize: 20.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    new Expanded(
                      child: new Text(
                        _text,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    return Container(
      height: 100.0,
      color: Colors.black12,
      child: Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: new EdgeInsets.all(0.5),
              child: new Column(
                children: <Widget>[
                  new Text(
                    _title + _title,
                    style: new TextStyle(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  new Expanded(
                    child: new Text(
                      _text,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
