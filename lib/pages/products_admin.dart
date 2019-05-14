import 'package:flutter/material.dart';

import 'products_drawer.dart';
import 'product_edit.dart';
import 'product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function updateProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;

  ProductsAdminPage(this.addProduct, this.updateProduct, this.deleteProduct, this.products);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: ProductsDrawer(),
        appBar: AppBar(
          title: Text('Products Admin'),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.create),
              text: 'Create Product'
            ),
            Tab(
              icon: Icon(Icons.list),
              text: 'My Products'
            )
          ])
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(addProduct: addProduct),
            ProductListPage(products, updateProduct)
          ]
        )
      )
    );
  }
}