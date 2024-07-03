import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'home_page.dart';
import '../services/session_timeout_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SessionTimeoutManager _sessionTimeoutManager = SessionTimeoutManager();
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Wait for the splash screen animation to complete
    await Future.delayed(Duration(seconds: 3));

    if (isLoggedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
  }

  @override
  void dispose() {
    _sessionTimeoutManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF277548),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo2.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
            Container(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  // Center(
                  //     child: Text(
                  //       'Bienvenue à notre service de commande et de réservation!',
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(primaryColor),
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                      
                    ), // Replace with your animated splash screen
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
