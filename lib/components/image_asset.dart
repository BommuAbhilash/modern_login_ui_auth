import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  const ImageAsset({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
        child: Image.asset(
          image,
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ));
  }
}
