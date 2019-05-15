import 'package:flutter/material.dart';
import 'products_drawer.dart';
import '../widgets/Products/products.dart';
import '../models/product.dart';


class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products);

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
      body: Products(products),
    );
  }
}