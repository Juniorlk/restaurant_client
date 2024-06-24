import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Favorite Restaurants',
      home: FavoriteRestaurantsPage(),
    );
  }
}

class FavoriteRestaurantsPage extends StatelessWidget {
  final List<Restaurant> restaurants = [
    Restaurant(
      name: 'The water fufu and eru',
      image: 'assets/eru.jpeg',
      price: '\$20.00',
    ),
    Restaurant(
      name: 'Poulet DG',
      image: 'assets/pouletDG.jpeg',
      price: '\$22.50',
    ),
    // Add more restaurants as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Plats Favoris'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantCard(restaurants[index]);
        },
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantCard(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              child: Image.asset(restaurant.image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  SizedBox(height: 8.0),
                  Text(restaurant.price),
                ],
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                // Add favorite logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Restaurant {
  final String name;
  final String image;
  final String price;

  Restaurant({
    required this.name,
    required this.image,
    required this.price,
  });
}