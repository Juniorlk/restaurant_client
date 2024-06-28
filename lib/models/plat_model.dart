// dish.dart
class Dish {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final bool isPromo;

  Dish({required this.id, required this.name, required this.imageUrl, required this.price, this.isPromo = false});

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['Id_Plat'],
      name: json['Nom'],
      imageUrl: json['Photos'],
      price: json['Prix'].toDouble(),
      isPromo: json['is_promo'] ?? false,
    );
  }
}


// static Future<User?> getUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? userData = prefs.getString('user');
//     if (userData != null) {
//       return User.fromJson(jsonDecode(userData));
//     }
//     return null;
//   }