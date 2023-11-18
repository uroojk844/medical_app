class CategoryModel {
  final String icon, name;

  CategoryModel({required this.icon, required this.name});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      icon: map["icon"],
      name: map["name"],
    );
  }
}
