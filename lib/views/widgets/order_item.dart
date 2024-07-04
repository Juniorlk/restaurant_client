import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final int idCommande;
  // final int itemCount;
  // final double distance;
  final int price;
  final int status;

  OrderItem({
    required this.idCommande,
    // required this.itemCount,
    // required this.distance,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(
          onTap: ()=>{
            print('ok')
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$idCommande',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text('12 articles - 1 km'),
                    SizedBox(height: 8),
                    Text('\$$price'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: status == 0
                      ? Colors.green
                      : (status == 1 ? Colors.blue : Colors.red),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status == 0 ? 'Actif' : status == 1 ? 'Terminé' : 'Annulé',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}