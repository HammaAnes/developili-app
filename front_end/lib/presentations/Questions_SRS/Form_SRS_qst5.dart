import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'Form_SRS_qst4.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'Form_SRS_qst6.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Importation du color picker
import '../api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_5th_question(),
    );
  }
}

class My_5th_question extends StatefulWidget {
  @override
  _My_5th_question_State createState() => _My_5th_question_State();
}

class _My_5th_question_State extends State<My_5th_question>
    with TickerProviderStateMixin {
  // Valeur de la couleur initiale
  Color _currentColor = Colors.blue;
  bool showForm = false; // Contrôle l'affichage du formulaire
  int currentPage = 4; // Page actuelle
  final int totalPages = 10; // Nombre total de pages
  bool isLoading = false; // Loading indicator
  bool showNext = false;

  // Méthode pour passer à la page suivante
  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_6th_question()),
    );
  }

  // Méthode pour revenir à la page d'accueil
  void _goBack2ndPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_4th_question()),
    );
  }

  // Submit the selected answer to the backend
  Future<void> _submitAnswer(String answer) async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await APIService.submitAnswer(
          1,
          13,
          answer,
          'handle_questions',
          'null'); // Example: client_id = 1, question_id = 1
      if (!(result["success"])) {
        
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${result["error"]}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit answer: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleBackButton() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await APIService.deleteAnswer(1, 12,
          'handle_questions'); // Replace with the actual client ID and question ID
      if (result["success"] == true) {
        _goBack2ndPage(); // Navigate to the previous page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to go back: ${result["error"]}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Méthode pour ouvrir le color picker
  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Affichage du color picker complet
            ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) {
                setState(() {
                  _currentColor = color; // Met à jour la couleur
                });
              },
              enableAlpha: false, // Option pour activer la transparence
              displayThumbColor:
                  true, // Affichage du pouce de la couleur choisie
              pickerAreaHeightPercent: 0.8, // Hauteur de l'aire de sélection
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              Color color = _currentColor;
              _submitAnswer("${color.red}+${color.green}+${color.blue}");
              showNext = true;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: CouleurDuFond.gradientBackground,
          ),
          child: Stack(
            children: [
              // Titre en haut de l'écran
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Questions",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Question principale
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Choose your color palette",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // Boutons Back et Next
              Positioned(
                bottom: 55,
                left: 20,
                child: ElevatedButton(
                  onPressed: _handleBackButton,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 55,
                right: 20,
                child: ElevatedButton(
                  onPressed: showNext
                  ? _goToNextPage
                  : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Bouton Pick Color au centre de l'écran
              Positioned(
                bottom: 300,
                left: 125,
                child: ElevatedButton(
                  onPressed: _openColorPicker,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    "Pick Color",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Indicateur de progression
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalPages, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: index < 5
                            ? const Color.fromARGB(255, 73, 255, 79)
                            : const Color.fromARGB(255, 7, 27, 139)
                                .withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
