import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/products.dart';
import 'product_edit.dart';

class ProductListPage extends StatelessWidget {

  Widget _buildEditButton(BuildContext context, String id){
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context){
              return ProductEditPage(id);
            }
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model){
        return ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return Dismissible(
              key: Key(model.products[index].title), //!fix later
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction){
                if(direction == DismissDirection.endToStart){
                  print('Dismissed end to start');
                  model.deleteProduct(model.products[index].id);
                }else if(direction == DismissDirection.startToEnd){
                  print('Dismissed end to start');
                  model.deleteProduct(model.products[index].id);
                }else{
                  print('Dismissed other direction');
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.products[index].image),
                    ),
                    title: Text('${model.products[index].title}'),
                    subtitle: Text('\$${model.products[index].price.toString()}'),
                    trailing: _buildEditButton(context, model.products[index].id)
                  ),
                  Divider()
                ]
              ),
            );
          },
          itemCount: model.products.length,
        );
      }
    );
  }
}