import 'package:flutter/material.dart';
import 'login_page.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'Welcome !!!',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Sign Up Here !',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
                   // child: _isLoading
                    //    ? const CircularProgressIndicator()
                     //   : Form(
                     //       key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Image.asset('assets/images/resto.png', width: 100, height: 100,),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'UserName'),
                                  validator: (value) => value!.isEmpty
                                      ? 'Email is required'
                                      : null,
                               //   onSaved: (value) => _email = value!,
                                ),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Phone Number'),
                                  validator: (value) => value!.isEmpty
                                      ? 'Email is required'
                                      : null,
                               //   onSaved: (value) => _email = value!,
                                ),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Email', suffixIcon: Icon(Icons.check, color: Colors.grey),),
                                  validator: (value) => value!.isEmpty
                                      ? 'Email is required'
                                      : null,
                               //   onSaved: (value) => _email = value!,
                                ),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Password',  suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),),
                                  validator: (value) => value!.isEmpty
                                      ? 'Password is required'
                                      : null,
                                //  onSaved: (value) => _password = value!,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white, 
                                    backgroundColor: Colors.green, 
                                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                                          'assets/images/google.png', width: 35, height: 35,),
                                      // iconSize: 5,
                                      onPressed: () {
                                        // Handle Google sign in
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    IconButton(
                                      icon: Image.asset('assets/images/facebook.png', width: 35, height: 35,),
                                      iconSize: 5,
                                      onPressed: () {
                                        // Handle Facebook sign in
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/twitter.png', width: 35, height: 35,),
                                      iconSize: 5,
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
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPage()));
                                  },
                                  child: const Text("Already register? login here"),
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
        //  ),
        ],
      ),
    );
  }
}
