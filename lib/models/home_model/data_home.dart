import 'package:shop_app/models/home_model/product_home.dart';
import 'banners_home.dart';

class  HomeData{
  List<Banners> banners = [];
  List<Products> products = [];
  HomeData.fromJson(Map<String,dynamic>json){
    json['banners'].forEach((element) {
      banners.add(Banners.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(Products.fromJson(element));
    });
  }
}