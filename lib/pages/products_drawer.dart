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
              leading: Icon(Icons.edit),
              title: Text('Manage Products', style: TextStyle(fontSize: 16.0),),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/admin');
              }
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List Products', style: TextStyle(fontSize: 16.0)),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/products');
              }
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
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