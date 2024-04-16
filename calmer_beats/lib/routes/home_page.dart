// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
    EmailAuthProvider,
    PhoneAuthProvider; // new
import 'package:flutter/material.dart'; // new
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // new

import '../app_state.dart'; // new
import '../authentication.dart'; // new
import '../widgets.dart';
import '../widgets/durationRadios.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.teal, foregroundColor: Colors.white,
        title: const Text('Calmer Beats'),
        actions: [IconButton(onPressed:(){context.go('/routes/Activity');},icon: Icon(Icons.tap_and_play), color: Colors.lightGreenAccent,), //use lightGreenAccent and pink for good contrast
          IconButton(onPressed:(){},icon: Icon(Icons.settings)),
          IconButton(onPressed:(){},icon: Icon(Icons.info_outline_rounded)),
          ],
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('lib/assets/mainWide.png',
            width: 250,
            height: 250,),
          const SizedBox(height: 8),
          //const IconAndDetail(Icons.tap_and_play, 'Connect'),
          //const IconAndDetail(Icons.settings, 'Settings'),

          //Login function
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          // to here
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("Welcome to Calmer Beats"),
          const Paragraph(
            "Let's take things down a notch\nSelect your duration and activity",
          ),
          DurationRadioWidget(),
        ],

      ),
    );
  }
}
