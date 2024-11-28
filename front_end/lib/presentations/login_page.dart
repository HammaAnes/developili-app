import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser() async {
    const String apiUrl = "http://127.0.0.1:8000/log_in/";
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 202) {
        final data = jsonDecode(response.body);
        if (data['success'] == "Successfully logged in") {
          // Navigate to the success page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyAppMain()),
          );
        } else {
          _showMessage(data['error'] ?? "Login failed");
        }
      } else {
        _showMessage("Something went wrong. Please try again.");
      }
    } catch (e) {
      _showMessage("An error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your email',
                style: TextStyle(color: Colors.white, fontSize: 16.43),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),
            const SizedBox(height: 25.8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your password',
                style: TextStyle(color: Colors.white, fontSize: 16.43),
              ),
            ),
            TextField(
              controller: passwordController,
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading ? null : loginUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login'),
            ),
            SizedBox(height: 10),

            // Texte non cliquable + Texte cliquable pour "Sign up"
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centrer horizontalement
              children: [
                Text(
                  "Don't have an account?",
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
                    'Sign up',
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
                'lib/icons/Logo_Google.png', // Assurez-vous que le logo est bien dans le dossier assets
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
                'lib/icons/apple-logo.png', // Assurez-vous que le logo est bien dans le dossier assets
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
