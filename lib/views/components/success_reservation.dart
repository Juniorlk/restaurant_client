import 'package:flutter/material.dart';
import 'package:foodapp/views/home_page_content.dart';
import 'package:lottie/lottie.dart';

class SuccessReservation extends StatefulWidget {
  const SuccessReservation({Key? key}) : super(key: key);

  @override
  State<SuccessReservation> createState() => _SuccessReservationState();
}

class _SuccessReservationState extends State<SuccessReservation> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds and then navigate back to the Home Page
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pop(context);
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
              child: Lottie.asset('images/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Reservation',
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
                      backgroundColor: const Color.fromARGB(255,255, 92, 0),
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
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Back to Home Page',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
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