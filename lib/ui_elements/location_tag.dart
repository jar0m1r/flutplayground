import 'package:flutter/material.dart';

class LocationTag extends StatelessWidget {
  final String location;

  LocationTag(this.location);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: 
          EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
        decoration: 
          BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 0.5, color: Colors.grey),),
        child: Text(
        location,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Assistant'
        )
      )
    );
  }
}