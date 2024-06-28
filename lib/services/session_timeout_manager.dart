import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_client/views/constants.dart';
import 'auth_service.dart';
import '../views/login_page.dart';

class SessionTimeoutManager {
  static const int sessionTimeout = Timeout; // Timeout duration in seconds
  Timer ?_timer;

  void initialize(BuildContext context) {
    _resetTimer(context);
  }

  void _resetTimer(BuildContext context) {
    _timer?.cancel();  // Annule le minuteur précédent s'il existe
    _timer = Timer(Duration(seconds: sessionTimeout), () async {
      await AuthService.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  void userInteractionDetected(BuildContext context) {
    _resetTimer(context);
  }

  void dispose() {
    _timer?.cancel();
  }
}
