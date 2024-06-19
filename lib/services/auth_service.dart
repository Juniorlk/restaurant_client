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
    print(response.statusCode);
    print(data);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);
      await prefs.setBool('isLoggedIn', true);
      return true;
    } else {
      debugPrint("pas bon");
      return false;
    }
  }

  static Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Nom': name,
        'AdresseMail': email,
        'MotDePasse': password,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool('isLoggedIn', false);
  }
}
