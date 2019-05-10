import 'package:flutter/material.dart';

class ProductsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Go to ...')
            ),
            ListTile(
              title: Text('Manage Products', style: TextStyle(fontSize: 16.0),),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/admin');
              }
            ),
            ListTile(
              title: Text('List Products', style: TextStyle(fontSize: 16.0)),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/products');
              }
            ),
            ListTile(
              title: Text('login', style: TextStyle(fontSize: 16.0)),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/');
              }
            )
          ]
        )
      );
  }
}