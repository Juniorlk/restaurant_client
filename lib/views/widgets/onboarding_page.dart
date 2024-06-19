import 'dart:ui';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool showStartButton;
  final VoidCallback onStartPressed;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    this.showStartButton = false,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: onStartPressed,
                    child: Text('Commencer'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
