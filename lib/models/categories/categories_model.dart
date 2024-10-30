class Categories {
  int id;
  String image;
  String name;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}