import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {@required String url,
      String lang = 'en',
      String token,
      Map<String, dynamic> query}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query ?? null);
  }

  static Future<Response> postData({
    @required String url,
    String lang = 'en',
    String token,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> upDateData({
    @required String url,
    String lang = 'en',
    String token,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.put(url, data: data);
  }
}
