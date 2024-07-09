

import 'package:flutter/material.dart';
import 'package:foodapp/views/constants.dart';
import './widgets/onboarding_page.dart';
import 'auth/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
   final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF277548),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              OnboardingPage(
                image: 'assets/images/splash_screen1.png',
                title: 'Bienvenue à notre service de commande et de réservation!',
                description:
                '',
                onStartPressed: ()=>{},
                first: true,
              ),
              OnboardingPage(
                image: 'assets/images/splash_screen1.png',
                title: 'Commandez facilement',
                description:
                'Avec notre application, parcourez notre vaste menu et commandez vos plats préférés en quelques clics.',
                onStartPressed: ()=>{},
              ),
              OnboardingPage(
                image: 'assets/images/splash_screen1.png',
                title: 'Réservez votre table',
                description:
                'Réservez une table à l’avance dans votre restaurant préféré et profitez d’une expérience culinaire sans tracas.',
                showStartButton: true,
                onStartPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                3,
                (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 10,
                    width: (index == _currentPage) ? 30 : 10,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: (index == _currentPage) ? Color(primaryColor) : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

