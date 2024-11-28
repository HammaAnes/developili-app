import 'package:flutter/material.dart';
import 'couleur_du_fond.dart'; // Import du fichier contenant le dégradé

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Enlever le banner de debug
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

  // Variable pour gérer l'état du Switch
  bool _isDeveloper = false;

  // Fonction pour comparer les mots de passe
  bool _passwordsMatch() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  // Fonction pour afficher une alerte si les mots de passe ne correspondent pas
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Error"),
        content: Text("Passwords do not match!"),
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

  // Fonction pour soumettre le formulaire
  void _submitForm() {
    if (_passwordsMatch()) {
      // Traiter le formulaire
      print("Form submitted with username: ${_usernameController.text}");
    } else {
      _showErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dégradé de fond appliqué à toute l'application
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground, // Appel du dégradé
        ),
        padding: EdgeInsets.all(20.0), // Padding autour de tous les éléments
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Aligner vers le haut
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            SizedBox(height: 40), // Espacement pour le titre

            // Titre de la page "Register"
            Text(
              'Register',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
                height:
                    40), // Espace entre le titre et le premier champ de formulaire

            // Formulaire pour le Username
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
            SizedBox(height: 25.8), // Espacement entre les champs de formulaire

            // Formulaire pour le Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your password',
                style: TextStyle(color: Colors.white, fontSize: 16.43),
              ),
            ),
            TextField(
              controller: _passwordController,
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
            SizedBox(height: 25.8), // Espacement entre les champs de formulaire

            // Formulaire pour vérifier le Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verify your password',
                style: TextStyle(color: Colors.white, fontSize: 16.43),
              ),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true, // Masquer le texte du mot de passe
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17.6),
                ),
              ),
            ),
            SizedBox(
                height: 10), // Espacement avant le texte "Are you a developer?"

            // Question "Are you a developer?" avec Switch et texte dynamique
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

            // Row pour placer "No" à gauche, le Switch et "Yes" à droite
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'No',
                  style: TextStyle(
                    color: !_isDeveloper
                        ? Colors.white
                        : Colors
                            .grey, // "No" est gris quand le switch est activé
                  ),
                ),
                SizedBox(width: 10), // Espacement entre le texte et le switch
                Switch(
                  value: _isDeveloper,
                  onChanged: (bool value) {
                    setState(() {
                      _isDeveloper = value;
                    });
                  },
                  activeTrackColor: Colors.blue,
                  activeColor:
                      Colors.white, // Couleur quand le switch est activé
                  inactiveThumbColor: Colors
                      .white, // Couleur du bouton du switch quand il est inactif
                  inactiveTrackColor: Colors
                      .grey, // Couleur du track quand le switch est inactif
                ),
                SizedBox(width: 10), // Espacement entre le switch et le texte
                Text(
                  'Yes',
                  style: TextStyle(
                    color: _isDeveloper
                        ? Colors.white
                        : Colors
                            .grey, // "Yes" est gris quand le switch est désactivé
                  ),
                ),
              ],
            ),

            SizedBox(height: 10), // Espacement avant le bouton de soumission

            // Bouton de soumission
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Couleur du fond du bouton
                foregroundColor: Colors.white, // Couleur du texte du bouton
                minimumSize: Size(double.infinity, 50), // Largeur du bouton
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
