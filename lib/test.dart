// DropdownButton<String>(
//               value: _selectedDay.isEmpty ? null : _selectedDay,
//               hint: Text('Sélectionner un jour'),
//               items: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche']
//                   .map((day) => DropdownMenuItem(
//                         child: Text(day),
//                         value: day,
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedDay = value ?? '';
//                   _slots = [];
//                   _tables = [];
//                   _selectedSlotId = null;
//                   _selectedTableId = null;
//                 });
//                 _loadSlots(value ?? '');
//               },
//             ),
//             if (_slots.isNotEmpty)
//               DropdownButton<int>(
//                 value: _selectedSlotId,
//                 hint: Text('Sélectionner un créneau'),
//                 items: _slots
//                     .map((slot) => DropdownMenuItem<int>(
//                           child: Text('${slot['Heure_debut']} - ${slot['Heure_fin']}'),
//                           value: slot['Id_Horaire'] as int,
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedSlotId = value;
//                     _tables = [];
//                     _selectedTableId = null;
//                   });
//                   _loadTables(value!, _numberOfPersons);
//                 },
//               ),
//             TextField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Nombre de personnes'),
//               onChanged: (value) {
//                 if (int.tryParse(value) != null) {
//                   int persons = int.parse(value);
//                   setState(() {
//                     _numberOfPersons = persons;
//                   });
//                   if (_selectedSlotId != null) {
//                     _loadTables(_selectedSlotId!, persons);
//                   }
//                 }
//               },
//             ),
//             if (_tables.isNotEmpty)
//               DropdownButton<int>(
//                 value: _selectedTableId,
//                 hint: Text('Sélectionner une table'),
//                 items: _tables
//                     .map<DropdownMenuItem<int>>((table) => DropdownMenuItem(
//                           child: Text('Table ${table['Numero_de_table']} (Capacité: ${table['Capacite']})'),
//                           value: table['Id_Table'],
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedTableId = value;
//                   });
//                 },
//               ),
//             ElevatedButton(
//               onPressed: _createReservation,
//               child: Text('Confirmer la réservation'),
//             ),