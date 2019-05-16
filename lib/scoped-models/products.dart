import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

mixin ProductsModel on Model{
  Map<String, Product> _products = {
    'asgasgasdgasdg': Product(
      id: 'asgasgasdgasdg',
      title: 'Rabarber Cake by Jaro',
      description: 'Dit is het. Zoek niet verder want dat is verspilde moeite. Bovendien zou je in dezelfde tijd een lekkere rabarber cake (by Jaro) kunnen eten. Denk niet langer na! Het is nu het moment. Niet straks maar nu!',
      price: 12.5,
      location: 'Veilinghaven, Utrecht',
      image: 'assets/food.jpg',
      isFavorite: false
    ),
    'gfdfahshsdfzdf': Product(
      id: 'gfdfahshsdfzdf',
      title: 'Happy Fudge Pudge',
      description: 'Al eeuwen bekend onder de kenners. Happy is de pudge niet. Fudgers zien dat anders and die moeten deze hebben. Ik sla em over in elk geval.',
      price: 37.0,
      location: 'Markthal, Rotterdam',
      image: 'assets/food.jpg',
      isFavorite: true
    )
  };

  List<Product> get products {
    //return List.from(_products); //!returns a reference of a copy of list and not reference to original
    return _products.values.toList();
  }

  Product product(String id) {
    return _products[id];
  }

  void addProduct(Product product) {
    Product newProduct = Product(
      id: 'id${product.title}',
      title: product.title,
      description: product.description,
      location: product.location,
      price: product.price,
      image: product.image,
      isFavorite: product.isFavorite
    );
    _products[newProduct.id] = newProduct; //!fix
    notifyListeners();
  }

  void updateProduct(Product product){
    _products[product.id] = product;
    notifyListeners();
  }

  void deleteProduct(String id){
    _products.remove(id);
    notifyListeners();
  }

  void toggleIsFavorite(String id){
    Product product = _products[id];
    Product newProduct = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      location: product.location,
      price: product.price,
      image: product.image,
      isFavorite: !product.isFavorite
    );
    _products[id] = newProduct;
    notifyListeners();
  }

  static ProductsModel of(BuildContext context) => ScopedModel.of<ProductsModel>(context);

}