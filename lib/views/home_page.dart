import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/session_timeout_manager.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SessionTimeoutManager _sessionTimeoutManager = SessionTimeoutManager();

  @override
  void initState() {
    super.initState();
    _sessionTimeoutManager.initialize(context);
  }

  @override
  void dispose() {
    _sessionTimeoutManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _sessionTimeoutManager.userInteractionDetected(context),
      onPanDown: (_) => _sessionTimeoutManager.userInteractionDetected(context),
      child: Scaffold(
        body: Center(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}
