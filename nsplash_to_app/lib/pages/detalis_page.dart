import 'package:flutter/material.dart';
import 'package:nsplash_to_app/models/user_model.dart';

class ImageDetalisPage extends StatelessWidget {
  final UserModel assetPath;

  const ImageDetalisPage({Key key, this.assetPath})
      : assert(assetPath != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.assetPath.altdescription),
      ),
      body: Center(
        child: Ink.image(
          image: NetworkImage(this.assetPath.pictureurllag),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
