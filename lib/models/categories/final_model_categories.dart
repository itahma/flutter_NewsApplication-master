import 'data_categories.dart';

class CategoriesModel {
  bool status;
  CategoriesData data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status   = json['status'];
    data     = CategoriesData.fromJson(json['data']);
  }
}
