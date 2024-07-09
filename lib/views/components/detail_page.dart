import 'package:flutter/material.dart';
import 'package:foodapp/models/plat_model.dart';

import '../constants.dart';

class DetailPage extends StatelessWidget {
  final Dish Plat;
  const DetailPage({super.key, required this.Plat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black),
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(onPressed: ()=> Navigator.pop(context), icon:  Image.asset('assets/icons/arrow-back2.png'),),
        backgroundColor: Colors.transparent,
        // title: Text(Plat.name),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.network("${baseUrl}/photos-${Plat.id}", width: double.infinity, fit: BoxFit.cover),
          ),

          Expanded(
            flex: 2,
            child: Text(Plat.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),

        ],
      )
    );
  }
}

// Center(
//         child: Text('${Plat.price}'),
//       ),