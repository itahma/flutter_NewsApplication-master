import 'data_home.dart';

class HomeModel {
  bool status;
  HomeData data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status   = json['status'];
    data     = HomeData.fromJson(json['data']);
  }
}
