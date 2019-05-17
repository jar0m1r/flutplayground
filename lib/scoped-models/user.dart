import './connected_products_user.dart';
import '../models/user.dart';

mixin UserModel on ConnectedProductsUserModel{
  void login(String email, String password){
    authenticatedUser = User(id: 'fix', email: email, password: password);
    print('Authenticated: ${authenticatedUser.email}');
  }
}