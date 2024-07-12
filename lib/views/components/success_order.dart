import 'package:flutter/material.dart';
import 'package:foodapp/views/constants.dart';
import 'package:foodapp/views/home_page_content.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({Key? key}) : super(key: key);

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds and then navigate back to the Home Page
    Future.delayed(Duration(seconds: 5), () async{
      // Navigator.pop(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child:SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(primaryColor),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageContent()),
                      );
                    },
                    // width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Page d\'accueil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}