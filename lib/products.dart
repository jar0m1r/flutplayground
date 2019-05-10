import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products) {
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
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  products[index]['title'],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Assistant'
                  )
                ),
                SizedBox(width: 18.0),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    '\$${products[index]['price'].toString()}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Assistant',
                      color: Colors.white
                    )
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: 
                    EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
                  decoration: 
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(width: 0.5, color: Colors.grey),),
                  child: 
                    Text(
                      products[index]['location'],
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Assistant'
                      )
                    )
                )
              ]
            )
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).primaryColor,
                // Navigator.PushNamed returns a Future which returns a generic (bool in this case) type, 
                // so possible to use .then and evaluate/use the bool 
                onPressed: () => Navigator.pushNamed<bool>(
                  context, 
                 '/product/' + index.toString() 
                )
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>( // Push returns a Future which returns a generic (bool) type
                  context, 
                 '/product/' + index.toString() 
                )
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
