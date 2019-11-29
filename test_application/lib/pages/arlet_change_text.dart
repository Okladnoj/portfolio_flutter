import 'package:flutter/material.dart';
import 'package:test_application/model/model_text.dart';

Future<void> cangeText({BuildContext context, ModelText modelText}) async {
  TextEditingController _textFieldController = TextEditingController();
  final _textdecor = 'Hey again!!!)))';
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Image'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You must insert new Text.'),
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: _textdecor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('ADD'),
            onPressed: () {
              final _newtxt = _textFieldController.text != ''
                  ? _textFieldController.text
                  : _textdecor;
              modelText.texthey = _newtxt;
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('CLEAR'),
            onPressed: () {
              _textFieldController.clear();
            },
          ),
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
