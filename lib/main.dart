import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/products_admin.dart';
import 'pages/products.dart';
import 'pages/product.dart';
import 'pages/auth.dart';
import 'scoped-models/products.dart';
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

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
      model: ProductsModel(),
      child: MaterialApp(
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
          '/products': (BuildContext context) => ProductsPage(), //home route, home property of MaterialApp will not work anymore
          '/admin' : (BuildContext context) => ProductsAdminPage()
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElement = settings.name.split('/');
          if(pathElement[0] != '') {
            return null;
          }
          if(pathElement[1] == 'product') {
            final int index = int.parse(pathElement[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index)
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings){
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductsPage();
            }
          );
        },
      ),
    );
  }
}
