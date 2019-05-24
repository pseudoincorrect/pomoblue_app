import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageAsset;
  const ImageContainer({Key key, this.imageAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Card(
        elevation: 5.0,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(4.0),
          ),
          child: Image.asset(imageAsset),
        ),
      ),
    );
  }
}
