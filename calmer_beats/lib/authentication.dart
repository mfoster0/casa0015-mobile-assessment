// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(!loggedIn ? Icons.login : Icons.logout),
          onPressed: () {
            !loggedIn ? Navigator.pushNamed(context, '/sign-in') : signOut();
          },
          tooltip: !loggedIn ? 'Login' : 'Logout',
        ),
        Visibility(
          visible: loggedIn,
          child: IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              //firebase profile
              Navigator.pushNamed(context, '/profile');
            },
            tooltip: 'Profile',
          ),
        )
      ],
    );
  }
}

/*
BELOW IS THE ORIGINAL LOGIN BUTTON IMPLEMENTATION

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: StyledButton(
              onPressed: () {
                !loggedIn ? context.push('/sign-in') : signOut();
              },
              child: !loggedIn ? const Text('Login') : const Text('Logout')),
        ),
        Visibility(
          visible: loggedIn,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: StyledButton(
                onPressed: () {
                  context.push('/profile');
                },
                child: const Text('Profile')),
          ),
        )
      ],
    );
  }
}
 */