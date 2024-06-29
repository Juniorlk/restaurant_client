import 'package:flutter/material.dart';
import 'package:foodapp/views/constants.dart';


class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE5E5E5),
      child: Center(
        child: Text(
          'Reservation Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(primaryColor),
          ),
        ),
      ),
    );
  }
}