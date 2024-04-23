import 'package:flutter/material.dart';

//display instructions to user
class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to use Calmer Beats"),
      ),
      body: Column(
        children: <Widget>[
          Image.asset('lib/assets/main_wide.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Select the duration for your activity for today and simply start your chosen exercise\n\nThe app allows you to connect to your pulse Calmer Beats monitor through the device connection icon in the toolbar\n\n You can connect to our backend to login to store any preferences through the Login Icon\n",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
