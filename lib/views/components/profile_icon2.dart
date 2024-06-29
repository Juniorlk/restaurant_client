import 'package:flutter/material.dart';

class ProfileIcon2 extends StatelessWidget {
  final String nom;
  const ProfileIcon2({super.key, required this.nom});
  String profileLetter() {
    if (nom.isEmpty) {
      return "U";
    }

    return nom[0].toUpperCase();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 30,
      // height: 30,
      // margin: const EdgeInsets.only(right: 10),
      // clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(206, 27, 172, 75),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(profileLetter(), textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E2300),
              )),
        ],
      ),
    );
  }
}