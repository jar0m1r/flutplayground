import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products(this.products,{this.deleteProduct} ) {
    print('[Products Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image'], 
            fit: BoxFit.cover, 
            colorBlendMode: BlendMode.softLight, 
            color: Colors.amber
            ),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>( //Push returns a Future which returns a generic (bool) type
                  context, 
                 '/product/' + index.toString() 
                ).then((bool value) {
                  if(value) {
                    deleteProduct(index);
                  }
                })
              )
            ]
            )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return _buildProductList();
  }
}
