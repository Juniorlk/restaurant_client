import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commandes',
      theme: ThemeData(
        primarySwatch: Colors.green,
        hintColor: Colors.green,
      ),
      home: OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Commandes'),
          bottom: TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Actif'),
              Tab(text: 'Terminé'),
              Tab(text: 'Annulé'),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            ActiveOrdersList(),
            CompletedOrdersList(),
            CancelledOrdersList(),
          ],
        ),
      ),
    );
  }
}

class ActiveOrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return OrderItem(
          restaurantName: 'Life of Salad',
          itemCount: 4,
          distance: 2.5,
          price: 24.00,
          status: 'Actif',
        );
      },
    );
  }
}

class CompletedOrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return OrderItem(
          restaurantName: 'Cafe Gourmand',
          itemCount: 2,
          distance: 1.8,
          price: 18.50,
          status: 'Terminé',
        );
      },
    );
  }
}

class CancelledOrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return OrderItem(
          restaurantName: 'Burger Palace',
          itemCount: 1,
          distance: 3.2,
          price: 12.75,
          status: 'Annulé',
        );
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final String restaurantName;
  final int itemCount;
  final double distance;
  final double price;
  final String status;

  OrderItem({
    required this.restaurantName,
    required this.itemCount,
    required this.distance,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('$itemCount articles - $distance km'),
                  SizedBox(height: 8),
                  Text('\$$price'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: status == 'Actif'
                    ? Colors.green
                    : (status == 'Terminé' ? Colors.blue : Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}