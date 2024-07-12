// services/reservation_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


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
  // Créez la réservation
  final response = await http.post(
    Uri.parse('$baseUrl/reservations'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(reservationData),
  );

  if (response.statusCode == 201) {
    // Si la création de la réservation a réussi, récupérez l'ID de la réservation
    final responseData = jsonDecode(response.body);
    // print('responseData: $responseData');
    final reservationId = responseData['reservation']['Id_Reservation'];
    // print(responseData['client']['Telephone']);
    final montant = 1;
    final tel = responseData['client']['Telephone'];
    final prenom = responseData['client']['Prenom'];
    final nom = responseData['client']['Nom'];
    // print('reservationId: $reservationId');

    // Lancer l'URL pour le paiement
    final paymentUrl = 'http://paiement.wuaze.com/examples/example1.php?montant=${montant}&tel=${tel}&reservation=${reservationId}&prenom=${prenom}&nom=${nom}';
    
    if (!await launchUrl(
      Uri.parse(paymentUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch');
    }
  } else {
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
