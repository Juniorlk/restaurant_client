import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String nom;
  const ProfileIcon({super.key, required this.nom});
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
            height: 5,
          ),
          Text(profileLetter(), textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF09596B),
              )),
        ],
      ),
    );
  }
}