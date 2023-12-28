import 'package:flutter/material.dart';

class Tooth extends StatelessWidget {
  var image;
  Tooth({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    if (image == '') {
      return Container(
          decoration: BoxDecoration(color: Color(0x40fbf9f9), borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(1),
          child: Center(
            child: Text(''),
          )
      );
    }
    else {
      return Container(
          decoration: BoxDecoration(color: Color(0x40fbf9f9), borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(1),
          child: Center(
            child: image,
          )
      );
    }
  }
}