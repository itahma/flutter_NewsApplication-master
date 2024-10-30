import 'package:shop_app/models/login_model/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  ShopLoginModel loginModelResponse;

  ShopRegisterSuccessState(this.loginModelResponse);
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordIcon extends ShopRegisterState {}
