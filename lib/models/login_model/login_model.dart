import 'package:shop_app/models/login_model/user_data.dart';

class ShopLoginModel {
  bool status;
  String message;
  UserData data;

  ShopLoginModel({this.status, this.message, this.data});

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}
