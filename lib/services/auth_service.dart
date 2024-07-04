import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/constants.dart';

class AuthService {
  static Future<int> login(String email, String password) async {
    try {
      var data = {
        'AdresseMail': email,
        'MotDePasse': password,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      // print(response.body);
      // print(data);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['access_token']);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('client', jsonEncode(responseData['client']));
        // print(responseData['client']);
        return response.statusCode;
      } else {
        return 401;
      }
    } catch (e) {
      return 2;
    }
  }

  static Future<int> register(String firstname, String lastname, String phone, String email, String password) async {
    try {
      var data = {
        "Nom": firstname,
        "Prenom": lastname,
        "AdresseMail": email,
        "MotDePasse": password,
        "Telephone": phone,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      // print(response.body);
      // print(data);
      response.statusCode == 200;

      return response.statusCode;
    } catch (e) {
      return 2;
    }
  }

  static Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.setBool('isLoggedIn', false);
    } catch (e) {
      debugPrint("Logout exception: $e");
    }
  }
}
