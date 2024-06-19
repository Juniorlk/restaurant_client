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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.cover,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: CircularProgressIndicator(), // Replace with your animated splash screen
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                    'Bienvenue à notre service de commande et de réservation!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
