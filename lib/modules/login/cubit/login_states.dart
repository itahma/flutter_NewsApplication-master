import 'package:shop_app/models/login_model/login_model.dart';

abstract class ShopLoginState {}
 class ShopLoginInitialState extends ShopLoginState{}
 class ShopLoadingState extends ShopLoginState{}
 class ShopLoginSuccessState extends ShopLoginState{
 ShopLoginModel loginModelResponse;
 ShopLoginSuccessState(this.loginModelResponse);
 }
 class ShopLoginErrorState extends ShopLoginState{
  final String error;

  ShopLoginErrorState(this.error);

 }


 class ShopLoginChangePasswordIcon extends ShopLoginState{}
