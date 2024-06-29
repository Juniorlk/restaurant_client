import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categorie_model.dart';
import '../views/constants.dart';

class CategorieService {
  // final String baseUrl;

  CategorieService();

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'),
    headers: {
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      return jsonResponse.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
  

}
