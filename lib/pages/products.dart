import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'products_drawer.dart';


class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductsPage(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProductsDrawer(),
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: ProductManager(products, addProduct, deleteProduct),
    );
  }
}