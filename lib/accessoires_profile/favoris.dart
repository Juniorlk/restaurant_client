import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Favorite Dishes',
      home: FavoriteDishesPage(),
    );
  }
}

class FavoriteDishesPage extends StatelessWidget {
  final List<Dish> dishes = [
    Dish(
      name: 'The water fufu and eru',
      image: 'assets/eru.jpeg',
      price: '\$20.00',
    ),
    Dish(
      name: 'Poulet DG',
      image: 'assets/pouletDG.jpeg',
      price: '\$22.50',
    ),
    // Add more dishes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Plats Favoris'),
      ),
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          return DishCard(dishes[index]);
        },
      ),
    );
  }
}

class DishCard extends StatelessWidget {
  final Dish dish;

  DishCard(this.dish);

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
              child: Image.asset(dish.image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dish.name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  SizedBox(height: 8.0),
                  Text(dish.price),
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

class Dish {
  final String name;
  final String image;
  final String price;

  Dish({
    required this.name,
    required this.image,
    required this.price,
  });
}