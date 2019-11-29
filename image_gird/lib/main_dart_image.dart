import 'package:flutter/material.dart';
import 'package:image_gird/image_details_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> mylinks;
  void metvork() {
    for (int i = 1; i <= 5; i++) {
      mylinks.add('images/cats/$i.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    mylinks = [];
    metvork();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: List.generate(mylinks.length, (index) {
              return Ink.image(
                image: AssetImage(mylinks[index]),
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ImageDetalisPage(assetPath: mylinks[index])));
                  },
                ),
              );
            })));
  }
}
