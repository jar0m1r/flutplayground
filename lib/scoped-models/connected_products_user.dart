import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../models/product.dart';

/*
 ! Problem here is the fact that (in order to let other mixins on MainModel access the properties products and AuthenticatedUser)
 ! the properties are exposed (not private), this could only be prevented by putting all Model Classes in one file. 
*/
mixin ConnectedProductsUserModel on Model {

  User authenticatedUser;

  Map<String, Product> products = {
    'asgasgasdgasdg': Product(
      id: 'asgasgasdgasdg',
      title: 'Rabarber Cake by Jaro',
      description: 'Dit is het. Zoek niet verder want dat is verspilde moeite. Bovendien zou je in dezelfde tijd een lekkere rabarber cake (by Jaro) kunnen eten. Denk niet langer na! Het is nu het moment. Niet straks maar nu!',
      price: 12.5,
      location: 'Veilinghaven, Utrecht',
      image: 'assets/food.jpg',
      createdById: 'fix', // ! fix
      isFavorite: false
    ),
    'gfdfahshsdfzdf': Product(
      id: 'gfdfahshsdfzdf',
      title: 'Happy Fudge Pudge',
      description: 'Al eeuwen bekend onder de kenners. Happy is de pudge niet. Fudgers zien dat anders and die moeten deze hebben. Ik sla em over in elk geval.',
      price: 37.0,
      location: 'Markthal, Rotterdam',
      image: 'assets/food.jpg',
      createdById: 'fix', // ! fix
      isFavorite: true
    )
  };

   void addProduct(Product product) {
      Map<String, dynamic> newProductMap = {
      'title': product.title,
      'description': product.description,
      'location': product.location,
      'price': product.price,
      'image': product.image,
      'createdById': authenticatedUser != null ? authenticatedUser.id : 'abcdefg', //! this is the reason why it is in the connected model, connecting user and product data
      'isFavorite': product.isFavorite     // ? but maybe it is better to keep models separate and let the page handle providing User data ?
      };
     http.post(
      'https://flutplayground.firebaseio.com/products.json',
      body: json.encode(newProductMap)
      )
      .then((http.Response response){
        final Map<String, dynamic> responseData = json.decode(response.body);
        Product newProduct = Product(
          id: responseData['name'],
          title: product.title,
          description: product.description,
          location: product.location,
          price: product.price,
          image: product.image,
          createdById: authenticatedUser != null ? authenticatedUser.id : 'abcdefg', //! this is the reason why it is in the connected model, connecting user and product data
          isFavorite: product.isFavorite     // ? but maybe it is better to keep models separate and let the page handle providing User data ?
        );
        products[newProduct.id] = newProduct;
        notifyListeners();
      });
  }

  void fetchProducts(){
    http
    .get('https://flutplayground.firebaseio.com/products.json')
    .then((http.Response response) {
      final Map<String, Product> fetchedProducts = {};
      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData.forEach((String productId, dynamic data) {
        final Product product = Product(
          id: productId,
          title: data['title'],
          description: data['description'],
          location: data['location'],
          price: data['price'],
          image: data['image'],
          createdById: data['createdById'],
          isFavorite: data['isFavorite']
        );
        fetchedProducts[productId] = product;
      });
      products = fetchedProducts;
      notifyListeners();
    });
  }


}