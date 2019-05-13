import 'package:flutter/material.dart';
import '../../ui_elements/title_default.dart';
import '../../ui_elements/location_tag.dart';

import 'price_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        TitleDefault(product['title']),
        SizedBox(width: 18.0),
        PriceTag(product['price'].toString())
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context){
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton( // ! info button
          icon: Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          // Navigator.PushNamed returns a Future which returns a generic (bool in this case) type, 
          // so possible to use .then and evaluate/use the bool 
          onPressed: () => Navigator.pushNamed<bool>(
            context, 
            '/product/' + productIndex.toString() 
          )
        ),
        IconButton( // ! favorite button
          icon: Icon(Icons.favorite_border),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>( // Push returns a Future which returns a generic (bool) type
            context, 
            '/product/' + productIndex.toString() 
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image'], 
            fit: BoxFit.cover, 
            colorBlendMode: BlendMode.softLight, 
            color: Colors.amber
            ),
          Container( // ! title & price
            margin: EdgeInsets.only(top: 20.0),
            child: _buildTitlePriceRow(),
          ),
          Container( // ! location
            margin: EdgeInsets.only(top: 20.0),
            alignment: Alignment.center,
            child: LocationTag(product['location'])
          ),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}