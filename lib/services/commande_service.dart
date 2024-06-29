import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:foodapp/views/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandeService {

  static Future<List<dynamic>> fetchOrders(int status) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? clientData = prefs.getString('client');
      // print('client data: $clientData');
      if (clientData == null) {
        return [];
      }

      Map<String, dynamic> client = jsonDecode(clientData);
      int clientId = client['Id_Client'];
      // print('client id: $clientId');
      // print('fetching orders');

      final response = await http.get(
        Uri.parse('$baseUrl/commandes/$clientId/$status'),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        List  orders = jsonDecode(response.body);
        return orders;
      } else {
        throw Exception('Failed to load orders');
      }
    }
}