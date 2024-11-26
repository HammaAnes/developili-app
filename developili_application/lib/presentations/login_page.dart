import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dégradé de fond appliqué à toute l'application
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2F3F6D),
              Color(0xff5693AD),
              Color(0xff6ABDCE),
              Color(0xff7EE7EE),
            ],
            stops: [0.0, 0.53, 0.75, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: const EdgeInsets.all(
            20.0), // Pour ajouter un padding autour de tous les éléments
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Aligner vers le haut
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            // Titre de la page "Login"
            const SizedBox(height: 40),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
                height: 40), // Réduire l'espace avant les champs de formulaire

            // Formulaire pour le Username
            const Align(
              alignment: Alignment.centerLeft, // Aligner à gauche
              child: Text(
                'Enter your username',
                style: TextStyle(color: Colors.white, fontSize: 16.43),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Username',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),
            const SizedBox(height: 25.8), // Espace entre les champs de formulaire

            // Formulaire pour le Password
            const Align(
              alignment: Alignment.centerLeft, // Aligner à gauche
              child: Text(
                'Enter your password',
                style: TextStyle(color: Colors.white, fontSize: 16.43),
              ),
            ),
            TextField(
              obscureText: true, // Masquer le texte du mot de passe
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),
            const SizedBox(
                height: 10), // Espacement avant le texte "Forget password?"

            // Texte "Forget password?" positionné à droite
            Align(
              alignment: Alignment.centerRight, // Aligner à droite
              child: TextButton(
                onPressed: () {
                  // Action de réinitialisation du mot de passe
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10), // Espace avant le bouton de soumission

            // Bouton de connexion
            ElevatedButton(
              onPressed: () {
                // Action de connexion
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Couleur de fond du bouton
                foregroundColor: Colors.white, // Couleur du texte du bouton
                minimumSize: const Size(double.infinity, 50), // Largeur du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
              child: Text('Login'),
            ),

            // Espace avant le texte "Don't have an account?" et "Sign up"
            const SizedBox(height: 10),

            // Texte non cliquable + Texte cliquable pour "Sign up"
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centrer horizontalement
              children: [
                const Text(
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
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4), // Espacement avant "or"

            // Texte "or" non cliquable
            const Text(
              'or',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),

            const SizedBox(
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
              label: const Text('Continue with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Couleur de fond
                foregroundColor: Colors.black, // Couleur du texte
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),

            const SizedBox(height: 20), // Espacement entre les boutons

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
              label: const Text('Continue with Apple'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Couleur de fond
                foregroundColor: Colors.black, // Couleur du texte
                minimumSize: const Size(double.infinity, 50),
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
