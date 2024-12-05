  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'couleur_du_fond.dart'; // Import the gradient background file

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      );
    }
  }

  class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    bool _isDeveloper = false;
    bool _isLoading = false;

    // Backend API URL
    final String apiUrl = "http://127.0.0.1:8000/registration/";

    // Function to check if passwords match
    bool _passwordsMatch() {
      return _passwordController.text == _confirmPasswordController.text;
    }

    // Function to handle API call for user registration
    Future<void> _registerUser() async {
      if (!_passwordsMatch()) {
        _showErrorDialog("Passwords do not match!");
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "username": _usernameController.text,
            "email": "${_usernameController.text}@gmail.com",
            "password": _passwordController.text,
            "role": _isDeveloper ? "developer" : "user",
          }),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 201) {
          _showSuccessDialog(responseData['message']);
        } else {
          _showErrorDialog(responseData['errors'] ?? "An unknown error occurred.");
        }
      } catch (error) {
        _showErrorDialog("Failed to connect to the server.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    // Function to show success dialog
    void _showSuccessDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }

    // Function to show error dialog
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: CouleurDuFond.gradientBackground,
          ),
          padding: EdgeInsets.all(20.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your username',
                        style: TextStyle(color: Colors.white, fontSize: 16.43),
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your password',
                        style: TextStyle(color: Colors.white, fontSize: 16.43),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Verify your password',
                        style: TextStyle(color: Colors.white, fontSize: 16.43),
                      ),
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Are you a developer?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'No',
                          style: TextStyle(
                            color: !_isDeveloper ? Colors.white : Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10),
                        Switch(
                          value: _isDeveloper,
                          onChanged: (bool value) {
                            setState(() {
                              _isDeveloper = value;
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Yes',
                          style: TextStyle(
                            color: _isDeveloper ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _registerUser,
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.6),
                        ),
                      ),
                    ),
                    // Espace avant le texte "Do you have an account?" et "Login"
            SizedBox(height: 10),

            // Texte non cliquable + Texte cliquable pour "Login"
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centrer horizontalement
              children: [
                Text(
                  "Do you have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Action pour l'inscription
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 4), // Espacement avant "or"

            // Texte "or" non cliquable
            Text(
              'or',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),

            SizedBox(
                height:
                    10), // Espacement avant les boutons "Continue with Google" et "Continue with Apple"

            // Bouton "Continue with Google"
            ElevatedButton.icon(
              onPressed: () {
                // Action pour se connecter avec Google
              },
              icon: Image.asset(
                'lib/icons/Logo_Google.png', // Assurez-vous que le logo est dans le dossier assets
                height: 24.0,
                width: 24.0,
              ),
              label: Text('Continue with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Couleur de fond
                foregroundColor: Colors.black, // Couleur du texte
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),

            SizedBox(height: 20), // Espacement entre les boutons

            // Bouton "Continue with Apple"
            ElevatedButton.icon(
              onPressed: () {
                // Action pour se connecter avec Apple
              },
              icon: Image.asset(
                'lib/icons/apple-logo.png', // Assurez-vous que le logo est dans le dossier assets
                height: 24.0,
                width: 24.0,
              ),
              label: Text('Continue with Apple'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Couleur de fond
                foregroundColor: Colors.black, // Couleur du texte
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),
                  ],
                ),
        ),
      );
    }
  }
