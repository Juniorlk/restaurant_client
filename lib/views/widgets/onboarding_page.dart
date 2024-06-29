import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/views/constants.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool showStartButton;
  final VoidCallback onStartPressed;
  final bool first;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    this.showStartButton = false,
    required this.onStartPressed,
    this.first = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover, // Adjust fit as needed
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: first == true ? MainAxisAlignment.end : MainAxisAlignment.center,
                children: [
                  // Image.asset(image, height: 300),
                  SizedBox(height: 320),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Assurez-vous que le texte est visible
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Assurez-vous que le texte est visible
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  if (showStartButton)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      onPressed: onStartPressed,
                      child: Text('Commencer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Assurez-vous que le texte est visible
                          )),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
