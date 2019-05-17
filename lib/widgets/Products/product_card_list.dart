import 'package:flutter/material.dart';
import 'product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCardListView extends StatelessWidget {
  final bool displayFavoritesOnly;

  ProductCardListView({this.displayFavoritesOnly = false});

  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => 
          ProductCard(products[index]),
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        if(displayFavoritesOnly){
          return _buildProductList(model.productList.where((product) => product.isFavorite).toList());
        }else{
          return _buildProductList(model.productList);
        }
      }
    );
  }
}
