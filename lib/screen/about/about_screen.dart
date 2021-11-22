
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget{
  static const routeName = '/about_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/consignt_logo.jpg', height: 150, width: 150,),
                SizedBox(height: 20,),
                Text('Version 1.0.0'),
                SizedBox(height: 10,),
                Text('Consignt is a marketplace for used electronic products that people want to sell easily.', textAlign: TextAlign.center,),
                //TODO: IF POSSIBLE, CLEAR CACHE BUTTON
              ],
            ),
        ),
      ),
    );
  }
  
}