import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String location;
  final double price;

  ProductPage(this.title, this.imageUrl, this.description, this.location, this.price);

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imageUrl),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 2.0
                    )
                  )
                ),
                padding: EdgeInsets.all(5.0),
                child: Text(
                  title, 
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )
                )
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      location, 
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal
                      )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        '|', 
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor
                        )
                      ),
                    ),
                    Text(
                      '\$${price.toString()}', 
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300
                      )
                    )
                  ]
                )
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  description, 
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal
                  )
                )
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: IconButton(
                  iconSize: 50.0,
                  icon: Icon(Icons.delete_forever),
                  color: Theme.of(context).accentColor,
                  //onPressed: () => Navigator.pop(context, true)
                  onPressed: () => _showWarningDialog(context) //anonymous function reference

                )
              )
            ]
          ),
        )
      )
    );
  }
}