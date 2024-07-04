// services/reservation_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/constants.dart';
import 'package:foodapp/views/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReservationService {

  Future<List<dynamic>> getSlotsByDay(String day) async {
    // print(day);
    final response = await http.get(Uri.parse('$baseUrl/slots/$day'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load slots');
    }
  }

  Future<List<dynamic>> getAvailableTables(int horaireId, int persons) async {
    final response = await http.get(Uri.parse('$baseUrl/tables/$horaireId/$persons'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tables');
    }
  }

  Future<void> createReservation(Map<String, dynamic> reservationData) async {
    // print(reservationData);
    final response = await http.post(
      Uri.parse('$baseUrl/reservations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reservationData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create reservation');
    }
  }

  Future<List<dynamic>> getReservationsByClient() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? clientData = prefs.getString('client');
      // print('client data: $clientData');
      if (clientData == null) {
        return [];
      }

      Map<String, dynamic> client = jsonDecode(clientData);
      int clientId = client['Id_Client'];
      print('client id: $clientId');
      // print('fetching orders');
    final response = await http.get(Uri.parse('$baseUrl/reservations/$clientId'),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
        },
      );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load reservations');
    }
    }
}
