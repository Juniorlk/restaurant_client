import 'package:flutter/material.dart';
import 'login_page.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String _firstname, _lastname, _phone, _email, _password;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // print(_firstname + _lastname + _phone + _email + _password);
      // Implement your registration logic here using AuthService
      int success = await AuthService.register(_firstname, _lastname, _phone, _email, _password);
      setState(() {
        _isLoading = false;
      });
      if (success == 200) {
        // Navigate to login or home page after successful registration
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else if (success == 401) {
        // Show an error message if registration fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Center(child: Text('Server Down')), backgroundColor: Colors.red,)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60, left: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome !!!',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sign Up Here !',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Form(
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Image.asset('assets/logo3.png', height: 120),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                            decoration: const InputDecoration(labelText: 'FirstName'),
                                            validator: (value) => value!.isEmpty ? 'Firstname is required' : null,
                                            onSaved: (value) => _firstname = value!,
                                          ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                                decoration: const InputDecoration(labelText: 'LastName'),
                                                validator: (value) => value!.isEmpty ? 'Lastname is required' : null,
                                                onSaved: (value) => _lastname = value!,
                                              ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              
                              
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Phone Number'),
                                validator: (value) => value!.isEmpty ? 'Phone number is required' : null,
                                onSaved: (value) => _phone = value!,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                                ),
                                validator: (value) => value!.isEmpty ? 'Email is required' : null,
                                onSaved: (value) => _email = value!,
                                
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                                ),
                                validator: (value) => value!.isEmpty ? 'Password is required' : null,
                                onSaved: (value) => _password = value!,
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _register,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Register'),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Sign in with',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Image.asset('assets/images/google.png', width: 35, height: 35),
                                          onPressed: () {
                                            // Handle Google sign in
                                          },
                                        ),
                                        const SizedBox(width: 20),
                                        IconButton(
                                          icon: Image.asset('assets/images/facebook.png', width: 35, height: 35),
                                          onPressed: () {
                                            // Handle Facebook sign in
                                          },
                                        ),
                                        const SizedBox(width: 20),
                                        IconButton(
                                          icon: Image.asset('assets/images/twitter.png', width: 35, height: 35),
                                          onPressed: () {
                                            // Handle Twitter sign in
                                          },
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginPage()),
                                        );
                                      },
                                      child: const Text("Already registered? Login here"),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
