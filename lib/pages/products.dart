import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
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

  Widget _buildCardList(){
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        if(model.isFetchingProducts){
          return Center(child: CircularProgressIndicator());
        }else if(!model.isFetchingProducts && model.productList.length > 0){
          return ProductCardListView(displayFavoritesOnly : displayFavoritesOnly);
        }else{
          return Center(child: Text('No products to show'));
        }
      });
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
      body: _buildCardList()
    );
  }
}