import 'package:flutter/material.dart';

class ProductsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose')
            ),
            ListTile(
              title: Text('Manage Products'),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/admin');
              }
            ),
            ListTile(
              title: Text('List Products'),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/products');
              }
            ),
            ListTile(
              title: Text('login'),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/');
              }
            )
          ]
        )
      );
  }
}