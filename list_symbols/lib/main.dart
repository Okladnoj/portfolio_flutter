import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'list_char.dart';

final _modelSymbolList = SimbolList().getSymbolList();

void main() => runApp(MainWidget());

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              child: Positioned.fill(
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('images/Scaffold_backgroundColor.jpg'),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: SybbolList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SybbolList extends StatefulWidget {
  @override
  _SybbolListState createState() => _SybbolListState();
}

class _SybbolListState extends State<SybbolList> {
  TextEditingController _controller;
  final key = new GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double titlSize = 15;
  double symbolSize = 80;
  Future<void> _neverSatisfied(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            color: Colors.green[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Обычный',
                      style: TextStyle(fontSize: titlSize),
                    ),
                    Container(
                      height: 20,
                    ),
                    Text(
                      'Жирный',
                      style: TextStyle(fontSize: titlSize),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Курсив',
                      style: TextStyle(fontSize: titlSize),
                    ),
                    Container(
                      height: 20,
                    ),
                    Text(
                      'Жирныйкурсив',
                      style: TextStyle(fontSize: titlSize),
                    ),
                  ],
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        color: Colors.blue.withAlpha(50),
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          _modelSymbolList[index],
                          style: TextStyle(
                              fontSize: symbolSize,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color: Colors.red.withAlpha(100),
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          _modelSymbolList[index],
                          style: TextStyle(
                              fontSize: symbolSize,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        color: Colors.red.withAlpha(100),
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          _modelSymbolList[index],
                          style: TextStyle(
                              fontSize: symbolSize,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color: Colors.blue.withAlpha(50),
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          _modelSymbolList[index],
                          style: TextStyle(
                              fontSize: symbolSize,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  child: Container(
                    color: Colors.grey[200],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          _modelSymbolList[index],
                          style: TextStyle(fontSize: titlSize * 2),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.content_copy),
                            Text(' CLICK to COPY'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Clipboard.setData(
                        new ClipboardData(text: _modelSymbolList[index]));
                    Fluttertoast.showToast(
                        msg: "Символ скопирован.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green[50],
              child: Icon(Icons.zoom_in),
              onPressed: () {
                symbolSize += 5;
                Navigator.of(context).pop();
                _neverSatisfied(index);
              },
            ),
            FlatButton(
              color: Colors.green[50],
              child: Icon(Icons.zoom_out),
              onPressed: () {
                symbolSize -= 5;
                Navigator.of(context).pop();
                _neverSatisfied(index);
              },
            ),
            FlatButton(
              color: Colors.green[50],
              child: Text('ВЫЙТИ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        itemCount: _modelSymbolList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 5 : 8),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              color: Colors.grey.withAlpha(200),
              child: Center(
                child: Container(
                  color: Colors.white.withAlpha(200),
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    _modelSymbolList[index],
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            onTap: () => _neverSatisfied(index),
          );
        },
      );
    });
  }
}
