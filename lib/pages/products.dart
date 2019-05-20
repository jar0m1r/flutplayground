import 'package:flutter/material.dart';
import 'products_drawer.dart';
import '../widgets/Products/product_card_list.dart';
import '../scoped-models/main.dart';



class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage>{
  bool displayFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    MainModel.of(context).fetchProducts();
    print('Init products page state');
  }

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