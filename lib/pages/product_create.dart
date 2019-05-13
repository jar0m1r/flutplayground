import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _descriptionValue = '';
  String _locationValue = '';
  double _priceValue;

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Title',
      ),
      onChanged: (String value){ 
        setState((){ 
          _titleValue = value;
        });
      }
    );
  }

  Widget _buildDescriptionTextField(){
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      onChanged: (String value){ 
        setState((){ 
          _descriptionValue = value;
        });
      }
    );
  } 

  Widget _buildLocationTextField(){
    return TextField(
      decoration: InputDecoration(
        labelText: 'location',
      ),
      onChanged: (String value){ 
        setState((){ 
          _locationValue = value;
        });
      }
    );
  }

  Widget _buildPriceTextField(){
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      onChanged: (String value){ 
        setState((){ 
          _priceValue = double.parse(value);
        });
      }
    );
  }  

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'location': _locationValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildLocationTextField(),
          _buildPriceTextField(),
          SizedBox(height: 15.0), //just some space between
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text('Save'),
            onPressed: _submitForm
          )
        ]
      )
    );
  }
}

// return Center(
//       child: RaisedButton(
//         child: Text('SAVE'),
//         onPressed: (){
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context){
//               return Center(
//                 child: Text('This is a Modal!')
//               );
//             }
//           )
//         }
//       )
//     );