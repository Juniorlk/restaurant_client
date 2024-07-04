import 'package:flutter/material.dart';
import 'package:foodapp/services/reservation_service.dart';

import 'constants.dart';

class ListReservationPage extends StatefulWidget {
  const ListReservationPage({super.key});

  @override
  State<ListReservationPage> createState() => _ListReservationPageState();
}

class _ListReservationPageState extends State<ListReservationPage> {
  final ReservationService _reservationService = ReservationService();
  List<dynamic> _reservations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    try {
      List<dynamic> reservations = await _reservationService.getReservationsByClient();
      setState(() {
        _reservations = reservations;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildStatusBadge(int status) {
    Color color;
    switch (status) {
      case 1:
        color = Colors.green;
        break;
      case 0:
        color = Colors.orange;
        break;
      case 2:
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status == 0 ? 'En attente' : status == 1 ? 'Confirmer' : 'Annuler',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des réservations'),
        leading: IconButton(
          icon: Image.asset('assets/icons/arrow-back2.png', width: 60),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _reservations.isEmpty
              ? Center(child: Text('Aucune réservation trouvée', style: TextStyle(fontSize: 24)))
              : ListView.builder(
                  itemCount: _reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = _reservations[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        leading: Icon(Icons.event, color: Color(primaryColor), size: 40),
                        title: Text(
                          'Réservation ${reservation['Id_Reservation']}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${reservation['Date_heure']}'),
                            Text('Table: ${reservation['Id_Table']}'),
                            Text('Personnes: ${reservation['Nombre_personnes']}'),
                          ],
                        ),
                        trailing: _buildStatusBadge(reservation['Statut']),
                      ),
                    );
                  },
                ),
    );
  }
}
