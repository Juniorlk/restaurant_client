import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plat_model.dart';
import 'package:foodapp/views/constants.dart';


class PlatService {
  // final String baseUrl;

  PlatService();

  Future<List<Dish>> fetchPromotions() async {
    final response = await http.get(Uri.parse('$baseUrl/promotions'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
    } else {
      throw Exception('Failed to load promotions');
    }
  }

  Future<List<Dish>> fetchPopularDishes() async {
    final response = await http.get(Uri.parse('$baseUrl/plats'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
      // print('object');
    } else {
      throw Exception('Failed to load popular dishes');
    }
  }
}
