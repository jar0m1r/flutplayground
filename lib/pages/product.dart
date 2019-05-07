import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(//to catch back event and controle popping
      onWillPop: (){
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false); //basically blocks further popping because row before already popped
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title)
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text(title)
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: RaisedButton(
                child: Text('delete'),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pop(context, true)
              )
            )
          ]
        )
      )
    );
  }
}