import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Title',
          ),
          onChanged: (String value){ 
            setState((){ 
              titleValue = value;
            });
          }
        ),
        TextField(
          maxLines: 4,
          onChanged: (String value){ 
            setState((){ 
              descriptionValue = value;
            });
          }
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (String value){ 
            setState((){ 
              priceValue = double.parse(value);
            });
          }
        ),
      ]
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