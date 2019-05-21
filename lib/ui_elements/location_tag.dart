import 'package:flutter/material.dart';

class LocationTag extends StatelessWidget {
  final String location;

  LocationTag(this.location);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: 
          EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
          margin: 
            EdgeInsets.symmetric(horizontal: 10.0),
        decoration: 
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 1.0, color: Colors.black),),
        child: Text(
        location,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Assistant'
        )
      )
    );
  }
}