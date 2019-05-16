import 'package:flutter/material.dart';
import 'products_drawer.dart';
import '../widgets/Products/products.dart';


class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProductsDrawer(),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: (){}
          )
        ]

      ),
      body: Products(),
    );
  }
}