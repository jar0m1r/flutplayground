import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './connected_products_user.dart';
import '../models/product.dart';

mixin ProductsModel on ConnectedProductsUserModel{

  List<Product> get productList {
    //return List.from(_products); //!returns a reference of a copy of list and not reference to original
    return products.values.toList();
  }

  Product product(String id) {
    return products[id];
  }

  void updateProduct(Product product){
    products[product.id] = product;
    notifyListeners();
  }

  void deleteProduct(String id){
    products.remove(id);
    notifyListeners();
  }

  void toggleIsFavorite(String id){
    Product product = products[id];
    Product newProduct = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      location: product.location,
      price: product.price,
      image: product.image,
      createdById: product.createdById,
      isFavorite: !product.isFavorite
    );
    products[id] = newProduct;
    notifyListeners();
  }

  static ProductsModel of(BuildContext context) => ScopedModel.of<ProductsModel>(context);

}