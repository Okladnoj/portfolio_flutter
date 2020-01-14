import 'package:flutter/material.dart';
import 'package:list_symbols/symbol_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final _modelSymbolList = ModelSymbolList().getListSimbol();

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
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        itemCount: _modelSymbolList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 6 : 8),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              color: Colors.white.withAlpha(200),
              child: Center(
                child: Text(
                  _modelSymbolList[index],
                  style: TextStyle(),
                ),
              ),
            ),
            onTap: () {
              Alert(
                context: context,
                //type: AlertType.info,
                title: _modelSymbolList[index],
                content: TextField(
                  enableInteractiveSelection: true,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: _modelSymbolList[index],
                  ),
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      'CANEL',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
            },
          );
        },
      );
    });
  }
}
