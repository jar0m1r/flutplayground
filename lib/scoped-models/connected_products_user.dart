import 'package:scoped_model/scoped_model.dart';

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
    Product newProduct = Product(
      id: 'id${product.title}',
      title: product.title,
      description: product.description,
      location: product.location,
      price: product.price,
      image: product.image,
      createdById: authenticatedUser.id, //! this is the reason why it is in the connected model, connecting user and product data
      isFavorite: product.isFavorite     // ? but maybe it is better to keep models separate and let the page handle providing User data ?
    );
    products[newProduct.id] = newProduct; // ! fix
    notifyListeners();
  }


}