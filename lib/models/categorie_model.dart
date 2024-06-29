// category.dart
class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['Id_Categorie'],
      name: json['Nom'],
      imageUrl: 'null',  //a modifier
    );
  }
}

