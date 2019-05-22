import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<Null> updateProduct(Product product){
    _isUpdatingProduct = true;
    notifyListeners();

    final Map<String, dynamic> updatedProduct = {
      'title': product.title,
      'description': product.description,
      'location': product.location,
      'price': product.price,
      'image': product.image,
      'createdById': product.createdById,
      'isFavorite': product.isFavorite
    };

    return http.put(
      'https://flutplayground.firebaseio.com/products/${product.id}.json', 
      body: json.encode(updatedProduct)
    )
    .then((http.Response response){
      if(response.body == null){
        print('Update Response Body from Server is Null');
        _isUpdatingProduct = false;
        notifyListeners();
      }
      Map<String, dynamic> responseData = json.decode(response.body);
      Product responseProduct = Product(
      id: responseData['name'],
      title: responseData['title'],
      description: responseData['description'],
      location: responseData['location'],
      price: responseData['price'],
      image: responseData['image'],
      createdById: responseData['createdById'],
      isFavorite: responseData['isFavorite']
      );
      products[product.id] = responseProduct;
      _isUpdatingProduct = false;
      notifyListeners();
    });
  }
  
  bool _isUpdatingProduct = false;
  bool get isUpdatingProduct{
    return _isUpdatingProduct;
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