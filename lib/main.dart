import 'package:flutter/material.dart';
import 'package:restaurant_client/accessoires_profile/favoris.dart' ;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      home: ProfilePage(),
      initialRoute: '/',
      routes: {
        '/favoris': (context) => FavoriteRestaurantsPage(),
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;

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
      ),
      body: Column(
        children: [
          UserProfileHeader(isDarkMode: isDarkMode),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Mes Favoris'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/favoris');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.local_offer),
                  title: Text('Offres Speciales'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Mode de Payements'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                // Ligne horizontale
                Divider(
                  color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
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
                    Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Address'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
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
                    color: isDarkMode ? Colors.red : null,
                  ),
                  title: Text('Deconnexion'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: isDarkMode ? Colors.red : null,
                  ),
                  onTap: () {
                    // Naviguer vers la page "My Favorite"
                    Navigator.pushNamed(context, '/my-favorite');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor, // Appliquer la couleur primaire à la barre de navigation
        selectedItemColor: Colors.green, // Couleur des icônes sélectionnées
        unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey, // Couleur des icônes non sélectionnées
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'E-Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class UserProfileHeader extends StatelessWidget {
  final bool isDarkMode;

  UserProfileHeader({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
            radius: 30,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Darren Bright',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '+237 651630073',
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