import 'package:flutter/material.dart';
import 'package:foodapp/views/home_page.dart';
import 'register_page.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool rememberMe = false;
  bool _isLoading = false; final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<bool> _isEmailValid = ValueNotifier<bool>(false);

   @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

   @override
  void dispose() {
    _emailController.dispose();
    _isEmailValid.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text;
    // Simple regex for email validation
    final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
    _isEmailValid.value = emailValid;
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState?.save();
      int success = await AuthService.login(_email, _password);
      print(success);
      setState(() {
        _isLoading = false;
      });
      if (success == 200) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if(success == 401){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid credentials')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Center(child: Text('Server Down')), backgroundColor: Colors.red,));
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
                    child: Text(
                      'Hello, Sign in!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                padding: const EdgeInsets.only(left: 10.0, right: 18.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Form(
                            key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Image.asset('assets/logo3.png', height: 180),
                                 ValueListenableBuilder<bool>(
                                  valueListenable: _isEmailValid,
                                  builder: (context, isValid, child) {
                                    return TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        suffixIcon: Icon(
                                          Icons.check,
                                          color: isValid ? Colors.green : Colors.grey,
                                        ),
                                      ),
                                      validator: (value) => value!.isEmpty
                                          ? 'Email is required'
                                          : null,
                                      onSaved: (value) => _email = value!,
                                    );
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                       InputDecoration(labelText: 'Password', suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),),
                                  validator: (value) => value!.isEmpty
                                      ? 'Password is required'
                                      : null,
                                  onSaved: (value) => _password = value!,
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: rememberMe,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            rememberMe = value ?? false;
                                          });
                                        },
                                      ),
                                      Text('Remember me'),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(onPressed: () {
                                           Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage()));
                                        }, child: const Text("Password forgot?", style: TextStyle(color: Colors.red),),),
                                      )
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white, backgroundColor: Colors.green, // Couleur du texte du bouton
                                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // Bordure arrondie du bouton
                                    ),
                                  ),
                                  child: const Text('Login'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()));
                                  },
                                  child: const Text("Don't have an account? Register"),
                                ),
                                const SizedBox(height: 20),
                                 Center(
                                  child: Column(
                                    children: [
                                      Text(
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
                                      icon: Image.asset(
                                          'assets/images/google.png', width: 25, height: 25,),
                                      // iconSize: 5,
                                      onPressed: () {
                                        // Handle Google sign in
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    IconButton(
                                      icon: Image.asset('assets/images/facebook.png', width: 25, height: 25,),
                                      iconSize: 5,
                                      onPressed: () {
                                        // Handle Facebook sign in
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/twitter.png', width: 25, height: 25,),
                                      iconSize: 5,
                                      onPressed: () {
                                        // Handle Twitter sign in
                                      },
                                    ),
                                  ],
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
          ),
          /*Positioned(
            top: 190,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: CircleAvatar(
              radius: 60, // Taille du cercle
              backgroundColor: Colors.orange,
              child: FlutterLogo(size: 40),
            ),
          ),*/
        ],
      ),
    );
  }
}
