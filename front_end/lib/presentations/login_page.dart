import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main_client.dart';
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
            MaterialPageRoute(builder: (context) => const ClientMain()),
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

  Future<void> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        final String idToken = auth.idToken!;

        final response = await http.post(
          Uri.parse("http://127.0.0.1:8000/social_login/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "provider": "google",
            "access_token": idToken,
          }),
        );

        if (response.statusCode == 200) {
          _showMessage("Logged in with Google successfully!");
        } else {
          _showMessage("Google login failed: ${response.body}");
        }
      } else {
        _showMessage("Google sign-in canceled.");
      }
    } catch (e) {
      _showMessage("Google login error: $e");
    }
  }

  Future<void> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/social_login/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "provider": "apple",
          "access_token": credential.identityToken!,
        }),
      );

      if (response.statusCode == 200) {
        _showMessage("Logged in with Apple successfully!");
      } else {
        _showMessage("Apple login failed: ${response.body}");
      }
    } catch (e) {
      _showMessage("Apple login error: $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: CouleurDuFond.gradientBackground,
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
              const SizedBox(height: 10),
              const Text('or',
                  style: TextStyle(color: Colors.black, fontSize: 16.0)),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: loginWithGoogle,
                icon: Image.asset(
                  'lib/icons/Logo_Google.png',
                  height: 24.0,
                  width: 24.0,
                ),
                label: const Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.6),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: loginWithApple,
                icon: Image.asset(
                  'lib/icons/apple-logo.png',
                  height: 24.0,
                  width: 24.0,
                ),
                label: const Text('Continue with Apple'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
