import 'package:shop_app/models/home_model/product_home.dart';

class FinalSearchModel {
  bool status;
  DataSearchModel data;

  FinalSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataSearchModel.fromJson(json['data']) : null;
  }
}

class DataSearchModel {
  List<Products> data = [];

  DataSearchModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Products.fromJson(element));
    });
  }
}


