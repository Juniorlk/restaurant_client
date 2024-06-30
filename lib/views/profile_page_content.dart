import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/services/auth_service.dart';
import 'package:foodapp/services/session_timeout_manager.dart';
import 'package:foodapp/views/components/profile_icon.dart';
import 'package:foodapp/views/components/profile_icon2.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;
  String _userName = '';
  String _telephone = '';
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? clientData = prefs.getString('client');
      if (clientData != null) {
        Map<String, dynamic> client = jsonDecode(clientData);
        setState(() {
          _userName = client['Prenom'];
          _telephone = client['Telephone'];
          _name = client['Nom'];
        });
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }


  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFF277548),
              
            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(0.05),
            child: Image.asset('assets/logo.png', width: 14, height: 14)
            ),
      ),
      body: Column(
        children: [
          UserProfileHeader(userName: _userName, isDarkMode: isDarkMode, telephone: _telephone, name: _name),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Mes Favoris'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    // Navigator.pushNamed(context, '/favoris');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Mode de Payements'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    // Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                // Ligne horizontale
                Divider(
                  color: isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    // Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Securites'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
                  },

                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Langues '),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.nightlight_round),
                  title: Text('Dark Mode'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: _toggleDarkMode,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: isDarkMode ? Colors.red : Colors.red,
                  ),
                  title: Text('Deconnexion',
                      style: TextStyle(color: isDarkMode ? Colors.red : Colors.red)
                      ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: isDarkMode ? Colors.red : Colors.red,
                  ),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    AuthService.logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}

class UserProfileHeader extends StatelessWidget {
  final userName;
  final telephone;
  final name;
  bool isDarkMode = false;

  UserProfileHeader({required this.userName, required this.isDarkMode, required this.telephone, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            child: ProfileIcon2(nom: userName)
            ),
          SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName+' '+name,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                telephone,
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}