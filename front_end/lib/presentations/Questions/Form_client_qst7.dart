import 'package:flutter/material.dart';
import 'Form_client_qst8.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'Form_client_qst6.dart';
import '../couleur_du_fond.dart';
import '../api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../user_get_id.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_7th_question(),
    );
  }
}

class My_7th_question extends StatefulWidget {
  @override
  _My_7th_question_State createState() => _My_7th_question_State();
}

class _My_7th_question_State extends State<My_7th_question>
    with TickerProviderStateMixin {
  int? boutonSelectionne; // Index du bouton sélectionné
  int currentPage = 6; // Page actuelle
  bool isLoading = false;
  bool showForm = false;
  final int totalPages = 8; // Nombre total de pages

  // Liste des noms des boutons
  final List<String> nomsBoutons = [
    'Highly involved',
    'Moderately involved',
    'Minimally involved',
  ];

  // Fonction pour naviguer vers une autre page
  void _goTo8thPage() {
    if (boutonSelectionne != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => My_8th_question()),
      );
    }
  }

  void _goBack6thPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_6th_question()),
    );
  }

  // Submit the selected answer to the backend
  Future<void> _submitAnswer(String answer) async {
    setState(() {
      isLoading = true;
    });

    try {
      final storage = FlutterSecureStorage();
      String? user_id = await storage.read(key: "user_id");
      int? id = getUserId(user_id);
      final result = await APIService.submitAnswer(id, 7, answer, 'handle_questions', 'null'); // Example: client_id = 1, question_id = 1
      if (result["success"]) {
        // Navigate to the next question on success
        _goTo8thPage();
      } else {
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
    final storage = FlutterSecureStorage();
      String? user_id = await storage.read(key: "user_id");
      int? id = getUserId(user_id);
    final result = await APIService.deleteAnswer(id, 8, 'handle_questions'); // Replace with the actual client ID and question ID
    if (result["success"]) {
      _goBack6thPage(); // Navigate to the previous page
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

  // Handles button selection and form display
  void _onOptionSelected(int index) {
    setState(() {
      boutonSelectionne = index;
      showForm =
          index == nomsBoutons.length; // Show form for the "Other" option
      if (!showForm) {
        _submitAnswer(nomsBoutons[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            // Sous-question
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "What is your preferred level of involvement in the development process ?",
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
            // Liste des boutons au centre
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(nomsBoutons.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap:  ()=> _onOptionSelected(index),
                        child: Container(
                          width: 318,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFBFD7E4).withOpacity(0.5),
                            border: Border.all(
                              color: boutonSelectionne == index
                                  ? Colors.blue
                                  : Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            nomsBoutons[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // Bouton "Back" en bas à gauche
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
            // Cercles de progression au centre en bas
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
                      color: index < 7 // Colore nombre de cercles
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
    );
  }
}
