import 'package:shop_app/models/home_model/product_home.dart';

class FinalFavoritesModel {
  bool status;
  DataFavoritesModel data;

  FinalFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataFavoritesModel.fromJson(json['data']) : null;
  }
}

class DataFavoritesModel {
  List<DataProductsModel> data = [];

  DataFavoritesModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataProductsModel.fromJson(element));
    });
  }
}

class DataProductsModel {
  int id;
  Products products;

  DataProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    products =
        json['product'] != null ? Products.fromJson(json['product']) : null;
  }
}
