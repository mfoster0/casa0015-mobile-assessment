import 'package:flutter/material.dart';
import 'package:calmer_beats/auth_service.dart'; // Ensure you have AuthService implemented

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginMode = true; // Toggle between login and register

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _isLoginMode ? _login() : _register(),
              child: Text(_isLoginMode ? 'Login' : 'Register'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoginMode = !_isLoginMode; // Toggle mode
                });
              },
              child: Text(_isLoginMode ? 'Need an account? Register' : 'Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    var user = await _authService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/home'); // Redirect to home if login successful
    } else {
      _showErrorDialog('Login failed');
    }
  }

  void _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    var user = await _authService.createUserWithEmailAndPassword(email, password);
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/home'); // Redirect to home if registration successful
    } else {
      _showErrorDialog('Registration failed');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}