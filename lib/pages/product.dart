import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  _showWarningDialog(BuildContext context){
    return showDialog( // Future so could do .then but in this case using Navigator.pop
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('This action cannot be undone!'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('DISCARD'), 
                      onPressed: () {
                        Navigator.pop(context);
                      }
                    ),
                    FlatButton(
                      child: Text('CONTINUE'), 
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      }
                      )
                  ]
                );
              }
            );
  }

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
                //onPressed: () => Navigator.pop(context, true)
                onPressed: () => _showWarningDialog(context) //anonymous function reference

              )
            )
          ]
        )
      )
    );
  }
}