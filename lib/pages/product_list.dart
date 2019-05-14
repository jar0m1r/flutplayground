import 'package:flutter/material.dart';
import '../widgets/Products/price_tag.dart';
import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  
  ProductListPage(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          leading: PriceTag(products[index]['price'].toString()),
          title: Text('${products[index]['title']}'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return ProductEditPage(product:products[index], productIndex: index, updateProduct:updateProduct);
                  }
                )
              );
            },
          ),
        );
      },
      itemCount: products.length,
    );
  }
}