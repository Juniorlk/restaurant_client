import 'package:flutter/material.dart';
import 'package:restaurant_client/views/home_page.dart';
import 'register_page.dart';
import '../services/auth_service.dart';
import './home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isLoading = false;

  _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState?.save();
      bool success = await AuthService.login(_email, _password);
      setState(() {
        _isLoading = false;
      });
      if (success) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading ? CircularProgressIndicator() : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Email is required' : null,
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) => value!.isEmpty ? 'Password is required' : null,
                  onSaved: (value) => _password = value!,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
