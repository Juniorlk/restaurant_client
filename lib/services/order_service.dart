import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/constants.dart';

class OrderService {

  Future<void> placeOrder(List<Map<String, dynamic>> plats, double prix, String modePaiement) async {
    // print('plats: $plats, prix: $prix, modePaiement: $modePaiement'); 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? clientData = prefs.getString('client');
    if (clientData == null) {
      throw Exception('Client non trouvé');
    }
    Map<String, dynamic> client = jsonDecode(clientData);

    // print('client: $client');
    String data = jsonEncode(<String, dynamic>{
      'Id_Client': client['Id_Client'], // Remplacez par l'ID du client connecté
      'Mode_paiement': modePaiement,
      'Prix': prix,
      'plats': plats,
    });

    // print('data: $data');
    final response = await http.post(
      Uri.parse('$baseUrl/commandes'),
      headers: {'Content-Type': 'application/json'},
      body: data
    );

    if (response.statusCode != 201) {
      throw Exception('Échec de la création de la commande');
    }
  }

  Future<void> placeOrder2(List<Map<String, dynamic>> plats, double prix, String modePaiement) async {
    final response = await http.post(
      Uri.parse('$baseUrl/commandes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Id_Client': 1, // Remplacez par l'ID du client connecté
        'Mode_paiement': modePaiement,
        'Prix': prix,
        'plats': plats,

      }),
    );

    if (response.statusCode == 200) {
      // Si la requête a réussi
      return jsonDecode(response.body);
    } else {
      // Si la requête a échoué
      throw Exception('Failed to place order');
    }
  }
}
