import 'package:flutter/material.dart';

import 'products_drawer.dart';
import 'product_create.dart';
import 'product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductsAdminPage(this.addProduct, this.deleteProduct);

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
            ProductCreatePage(addProduct),
            ProductListPage()
          ]
        )
      )
    );
  }
}