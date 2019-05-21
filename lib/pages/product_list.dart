import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return ListView.builder(
          itemBuilder: (BuildContext context, int index){
            final String imageUrl = model.productList[index].image;
            return Dismissible(
              key: Key(model.productList[index].title), //!fix later
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction){
                if(direction == DismissDirection.endToStart){
                  print('Dismissed end to start');
                  model.deleteProduct(model.productList[index].id);
                }else if(direction == DismissDirection.startToEnd){
                  print('Dismissed end to start');
                  model.deleteProduct(model.productList[index].id);
                }else{
                  print('Dismissed other direction');
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: imageUrl.startsWith('assets') ? AssetImage(imageUrl) : NetworkImage(imageUrl),
                    ),
                    title: Text('${model.productList[index].title}'),
                    subtitle: Text('\$${model.productList[index].price.toString()}'),
                    trailing: _buildEditButton(context, model.productList[index].id)
                  ),
                  Divider()
                ]
              ),
            );
          },
          itemCount: model.productList.length,
        );
      }
    );
  }
}