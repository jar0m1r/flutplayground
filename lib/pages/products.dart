import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'products_drawer.dart';


class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProductsDrawer(),
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: ProductManager(),
    );
  }
}