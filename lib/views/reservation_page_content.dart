import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/views/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/reservation_service.dart';
import 'list_reservation_page.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final ReservationService _reservationService = ReservationService();
  List<dynamic> _slots = [];
  List<dynamic> _tables = [];
  DateTime? _selectedDate;
  int? _selectedSlotId;
  int? _selectedTableId;
  int _numberOfPersons = 1;

  @override
  void initState() {
    super.initState();
  }

  List<DateTime> getNext7Days() {
    DateTime today = DateTime.now();
    return List.generate(7, (index) => today.add(Duration(days: index + 1)));
  }

  Future<void> _loadSlots(DateTime date) async {
    try {
      String dayOfWeek = _getDayOfWeek(date);
      List<dynamic> slots = await _reservationService.getSlotsByDay(dayOfWeek);
      setState(() {
        _slots = slots;
      });
    } catch (e) {
      print(e);
    }
  }

  String _getDayOfWeek(DateTime date) {
    List<String> days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return days[date.weekday - 1];
  }

  Future<void> _loadTables(int slotId, int persons) async {
    try {
      List<dynamic> tables = await _reservationService.getAvailableTables(slotId, persons);
      setState(() {
        _tables = tables;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _createReservation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? clientData = prefs.getString('client');
      // print('client data: $clientData');
      if (clientData == null) {
        return ;
      }

      Map<String, dynamic> client = jsonDecode(clientData);
      int clientId = client['Id_Client'];

      if (_selectedSlotId == null || _selectedTableId == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          action: SnackBarAction(
            label: 'X',
            onPressed: () {},
          ),
          backgroundColor: Color.fromARGB(255, 244, 67, 54),
          content: Text('Veuillez sélectionner un créneau et une table.'),
        ));
        return;
      }

      Map<String, dynamic> reservationData = {
        'Id_Client': clientId, // Remplacer par l'ID du client connecté
        'Date_heure': _selectedDate!.toIso8601String(),
        'Mode_paiement': 'Carte de crédit',
        'Id_Table': _selectedTableId,
        'Id_Horaire': _selectedSlotId,
        'Nombre_personnes': _numberOfPersons,
        'Statut': 'En attente',
      };

      await _reservationService.createReservation(reservationData);


      // Clear the form fields
      setState(() {
        _selectedDate = null;
        _selectedSlotId = null;
        _selectedTableId = null;
        _numberOfPersons = 1;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          action: SnackBarAction(
            label: 'X',
            onPressed: () {},
          ),
        content: Text('Réservation effectuée avec succès !'),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          action: SnackBarAction(
            label: 'X',
            onPressed: () {},
          ),
        backgroundColor: const Color.fromARGB(125, 244, 67, 54),
        content: Text('Erreur lors de la réservation'),
      ));
    }
  }

  Widget _buildTableIcon(int capacity) {
    // Cette fonction retourne une icône personnalisée en fonction de la capacité de la table.
    return   capacity > 8 ? Image.asset('assets/icons/arrow-back2.png', width: 60,): capacity > 6 ? Image.asset('assets/icons/table8.png', width: 60,): capacity > 4 ? Image.asset('assets/icons/table6.png', width: 60,): capacity > 2 ? Image.asset('assets/icons/table4.png', width: 60,): Image.asset('assets/icons/table2.png', width: 60,);

  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> next7Days = getNext7Days();

    return Scaffold(
      appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(6),
            color: Color(0xFF277548),
            padding: EdgeInsets.all(3),
            child: Image.asset('assets/logo.png', width: 14, height: 14)
          ),
          title: Text('Réservation de tables', style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListReservationPage()));
              }, 
            icon:  Icon(Icons.list, color: Color(primaryColor)),),
          ],
        ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choisir une date',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Les reservations se font uniquement les 7 prochains jours',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Afficher les 7 prochains jours
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 3, crossAxisSpacing: 10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: next7Days.map((date) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = date;
                          _slots = [];
                          _tables = [];
                          _selectedSlotId = null;
                          _selectedTableId = null;
                        });
                        _loadSlots(date);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: _selectedDate == null
                              ? Colors.grey
                              : _getDayOfWeek(_selectedDate!) == _getDayOfWeek(date)
                                  ? Color(primaryColor)
                                  : Color(0xAE9E9E9E),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                  color: _selectedDate == null
                                      ? Colors.black
                                      : _getDayOfWeek(_selectedDate!) == _getDayOfWeek(date)
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _getDayOfWeek(date),
                              style: TextStyle(
                                color: _selectedDate == null
                                    ? Colors.black
                                    : _getDayOfWeek(_selectedDate!) == _getDayOfWeek(date)
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 35,
                ),
                if (_slots.isNotEmpty)
                  Column(
                    children: [
                      Text('Choisir un creneau'),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<int>(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: const Color(primaryColor), fontSize: 16),
                          underline: Container(
                            height: 2,
                            color: const Color(primaryColor),
                            alignment: Alignment.centerLeft,
                          ),
                          isExpanded: true,
                          value: _slots.any((slot) => slot['Id_Horaire'] == _selectedSlotId) ? _selectedSlotId : null,
                          hint: Text('Sélectionner un créneau'),
                          items: _slots.map((slot) {
                            return DropdownMenuItem<int>(
                              child: Text('${slot['Heure_debut']} - ${slot['Heure_fin']}'),
                              value: slot['Id_Horaire'] as int,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSlotId = value;
                              _tables = [];
                              _selectedTableId = null;
                            });
                            if (value != null) {
                              _loadTables(value, _numberOfPersons);
                            }
                          },
                        ),
                      ),
                    ],
                  )else(
                  Text('Aucune Creneau disponible pour le moment')
                  ),

                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nombre de personnes',
                    hintText: '1 Par defaut',
                    labelStyle: TextStyle(color: Color(primaryColor)),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(primaryColor)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))
                  ),
                  onChanged: (value) {
                    if (int.tryParse(value) != null) {
                      int persons = int.parse(value);
                      setState(() {
                        _numberOfPersons = persons;
                      });
                      if (_selectedSlotId != null) {
                        _loadTables(_selectedSlotId!, persons);
                      }
                    }
                  },
                ),
                SizedBox(height: 25),
                if (_tables.isNotEmpty)
                  Column(
                    children: [
                      Text('Choisir une table'),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: _tables.map((table) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('${table['Capacite']} places'),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _selectedTableId == table['Id_Table'] ? Color(primaryColor) : Colors.grey,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: _buildTableIcon(table['Capacite']),
                                    onPressed: () {
                                      setState(() {
                                        _selectedTableId = table['Id_Table'];
                                      });
                                    },
                                    color: _selectedTableId == table['Id_Table'] ? Color(primaryColor) : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )else(
                  Text('Aucune table de cette capacité disponible pour le moment')
                  ),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: _createReservation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Confirmer la réservation', style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
