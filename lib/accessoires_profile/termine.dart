import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders',
      home: OrdersPage(),
    );
  }
}

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Completed', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Cancelled', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16.0),
            OrderCard(
              title: 'Zero Zero Noodles',
              price: 22.00,
              items: 4,
              distance: '2.7 km',
              status: 'Completed',
              onLeaveReview: () {},
              onOrderAgain: () {},
            ),
            SizedBox(height: 16.0),
            OrderCard(
              title: 'Eats Meets West',
              price: 20.50,
              items: 2,
              distance: '1.9 km',
              status: 'Completed',
              onLeaveReview: () {},
              onOrderAgain: () {},
            ),
            SizedBox(height: 16.0),
            OrderCard(
              title: 'Gardenica Salad',
              price: 27.00,
              items: 3,
              distance: '2.2 km',
              status: 'Completed',
              onLeaveReview: () {},
              onOrderAgain: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final double price;
  final int items;
  final String distance;
  final String status;
  final VoidCallback onLeaveReview;
  final VoidCallback onOrderAgain;

  OrderCard({
    required this.title,
    required this.price,
    required this.items,
    required this.distance,
    required this.status,
    required this.onLeaveReview,
    required this.onOrderAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${price.toStringAsFixed(2)}'),
                Text('$items items | $distance'),
                Text(
                  status,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onLeaveReview,
                  child: Text('Leave a Review'),
                ),
                TextButton(
                  onPressed: onOrderAgain,
                  child: Text('Order Again'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}