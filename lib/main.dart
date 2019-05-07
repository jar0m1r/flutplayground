import 'package:flutter/material.dart';
import 'pages/auth.dart';
import 'pages/products_admin.dart';
import 'pages/products.dart';
import 'pages/product.dart';
// import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.amber
        ),
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) => ProductsPage(), //home route, home property of MaterialApp will not work anymore
        '/admin' : (BuildContext context) => ProductsAdminPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElement = settings.name.split('/');
        if(pathElement[0] != '') {
          return null;
        }
        if(pathElement[1] == 'product') {
          final int index = int.parse(pathElement[2]);
          return MaterialPageRoute(
            builder: (BuildContext context) => ProductPage(
              products[index]['title'], 
              products[index]['image']
            )
          );
        }
      }
    );
  }
}
