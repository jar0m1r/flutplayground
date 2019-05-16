import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model{

  List<Product> _products = [
    Product(
      title: 'Rabarber Cake by Jaro',
      description: 'Dit is het. Zoek niet verder want dat is verspilde moeite. Bovendien zou je in dezelfde tijd een lekkere rabarber cake (by Jaro) kunnen eten. Denk niet langer na! Het is nu het moment. Niet straks maar nu!',
      price: 12.5,
      location: 'Veilinghaven, Utrecht',
      image: 'assets/food.jpg'
    ),
    Product(
      title: 'Happy Fudge Pudge',
      description: 'Al eeuwen bekend onder de kenners. Happy is de pudge niet. Fudgers zien dat anders and die moeten deze hebben. Ik sla em over in elk geval.',
      price: 37.0,
      location: 'Markthal, Rotterdam',
      image: 'assets/food.jpg'
    )
  ];

  List<Product> get products {
    return List.from(_products); //!returns a reference of a copy of list and not reference to original
  }

  void addProduct(Product product) {
    _products.add(product);
    print(_products);
  }

  void updateProduct(int index, Product product){
    _products[index] = product;
  }

  void deleteProduct(int index){
    _products.removeAt(index);
  }

}