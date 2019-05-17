import 'package:scoped_model/scoped_model.dart';
import './user.dart';
import './products.dart';
import './connected_products_user.dart';

class MainModel extends Model with ConnectedProductsUserModel, UserModel, ProductsModel {
  
}