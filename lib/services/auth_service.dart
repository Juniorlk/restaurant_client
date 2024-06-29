import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/constants.dart';

class AuthService {
  // static const String baseUrl = 'http://192.168.1.197:80/api';

  static Future<bool> login(String email, String password) async {
      var data = {
        'AdresseMail': email,
        'MotDePasse': password,
      };
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Accept': 'application/json; charset=UTF-8',
      },
      body: data,
    );
    // print(response.statusCode);
    // print(data);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('client', jsonEncode(data['client']));
      // print(data['client']);
      return true;
    } else {
      debugPrint("pas bon");
      return false;
    }
  }

  static Future<bool> register(String firstname,String lastname, String phone, String email, String password) async {
      var data = {
        "Nom": firstname,
        "Prenom": lastname,
        "AdresseMail": email,
        "MotDePasse": password,
        "Telephone": phone,
      };
      // print(data);
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Accept': 'application/json; charset=UTF-8',
      },
      body: data,
    );
    // print(response.statusCode);

    return response.statusCode == 200;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool('isLoggedIn', false);
  }
}
