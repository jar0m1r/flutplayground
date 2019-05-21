import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ui_elements/title_default.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';


class ProductPage extends StatelessWidget {
  final String productId;

  ProductPage(this.productId);

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

  Widget _buildLocationPriceRow(Product product){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          product.location, 
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
              fontWeight: FontWeight.normal
            )
          ),
        ),
        Text(
          '\$${product.price.toString()}', 
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w300
          )
        )
      ]
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
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model){
          Product product = model.product(productId);
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title)
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  product.image.startsWith('assets') ? Image.asset(product.image) : Image.network(product.image),
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
                    child: TitleDefault(product.title)
                  ),
                  _buildLocationPriceRow(product),
                  SizedBox(height: 15.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      product.description, 
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(
                          'created by: ${product.createdById}',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w300
                          ),
                        )
                      ]
                    ),
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
          );
        }
      )
    );
  }
}