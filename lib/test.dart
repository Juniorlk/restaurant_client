// import 'package:flutter/material.dart';
// import 'package:foodapp/views/payment_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login Screen',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF0C6904),
//                   Color(0xFF12AC04),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.only(top: 60, left: 22),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hello, Sign in!',
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Center(
//                     child: CircleAvatar(
//                       radius: 60, // Taille du cercle
//                       backgroundColor: Colors.orange,
//                       child: FlutterLogo(size: 40),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 250.0),
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 color: Colors.white,
//               ),
//               height: double.infinity,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 18.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 20),
//                     TextField(
//                       decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.check, color: Colors.grey),
//                         label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)),
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
//                         label: Text('Password', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)),
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.visiblePassword,
//                     ),
//                     SizedBox(height: 30),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Text('Forgot Password ?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff281537))),
//                     ),
//                     SizedBox(height: 50),
//                     Container(
//                       height: 55,
//                       width: 300,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFF0C6904),
//                             Color(0xFF12AC04),
//                           ],
//                         ),
//                       ),
//                       child: Center(
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const AdeFlutterExample()),
//                             );
//                           },
//                           child: Text(
//                             'Sign in',
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       )
//                     ),
//                     SizedBox(height: 50),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Text('Don\'t have account ?', style: TextStyle(fontSize: 15, color: Color(0xff281537))),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
