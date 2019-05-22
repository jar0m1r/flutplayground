import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';
import '../../ui_elements/title_default.dart';
import '../../ui_elements/location_tag.dart';
import '../../models/product.dart';
import 'price_tag.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  Widget _buildTitlePriceRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        TitleDefault(product.title),
        SizedBox(width: 18.0),
        PriceTag(product.price.toString())
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context){
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton( // ! info button
          icon: Icon(Icons.local_dining),
          color: Theme.of(context).primaryColor,
          // Navigator.PushNamed returns a Future which returns a generic (bool in this case) type, 
          // so possible to use .then and evaluate/use the bool 
          onPressed: () => Navigator.pushNamed<bool>(
            context, 
            '/product/' + product.id
          )
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model){
            return IconButton( // ! favorite button
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () => model.toggleIsFavorite(product.id)
            );
          }
        )
      ]
    );
  }

  Widget _buildImage(){
    return product.image.startsWith('assets') 
    ? Image.asset(
        product.image, 
        fit: BoxFit.cover, 
        colorBlendMode: BlendMode.softLight, 
        color: Colors.amber
      )
    : FadeInImage(
        fit: BoxFit.cover,
        height: 300.0,
        placeholder: AssetImage(
          'assets/food.jpg', 
        ),
        image: NetworkImage(
          product.image
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              _buildImage(),
              Container( // ! location
                margin: EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.topLeft,
                child: LocationTag(product.location)
              )
            ]
          ),
          Container( // ! title & price
            margin: EdgeInsets.only(top: 20.0),
            child: _buildTitlePriceRow(),
          ),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}