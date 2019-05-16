import 'package:flutter/material.dart';
import 'products_drawer.dart';
import '../widgets/Products/product_card_list.dart';


class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage>{
  bool displayFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ProductsDrawer(),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: (){
              setState((){displayFavoritesOnly = !displayFavoritesOnly;});
            }
          )
        ]

      ),
      body: ProductCardListView(displayFavoritesOnly : displayFavoritesOnly),
    );
  }
}