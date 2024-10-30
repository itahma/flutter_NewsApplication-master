import 'categories_model.dart';

class  CategoriesData{
  int currentPage;
  List<Categories> categories = [];
  CategoriesData.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      categories.add(Categories.fromJson(element));
    });

  }
}