import 'package:flutter/material.dart';
import 'pages/products_admin.dart';
import 'pages/products.dart';
import 'pages/product.dart';
import 'pages/auth.dart';
import 'models/product.dart';
// import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
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

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
    print(_products);
  }

  void _updateProduct(int index, Product product){
    setState((){
      _products[index] = product;
    });
  }

  void _deleteProduct(int index){
    setState((){
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.amber,
          primaryColor: Colors.indigo,
          buttonColor: Colors.amber,
          fontFamily: 'Assistant'
        ),
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products), //home route, home property of MaterialApp will not work anymore
        '/admin' : (BuildContext context) => ProductsAdminPage(_addProduct, _updateProduct, _deleteProduct, _products)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElement = settings.name.split('/');
        if(pathElement[0] != '') {
          return null;
        }
        if(pathElement[1] == 'product') {
          final int index = int.parse(pathElement[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(_products[index])
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return ProductsPage(_products);
          }
        );
      },
    );
  }
}
