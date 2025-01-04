import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'qst5_dev.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'qst7_dev.dart';
import 'package:flutter/services.dart'; // N'oubliez pas d'importer ce package pour FilteringTextInputFormatter
import '../api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_6th_question(),
    );
  }
}

class My_6th_question extends StatefulWidget {
  @override
  _My_6th_question_State createState() => _My_6th_question_State();
}

class _My_6th_question_State extends State<My_6th_question> {
  bool isMinimumSelected = false; // Indique si "Minimum" est sélectionné
  bool isMaximumSelected = false; // Indique si "Maximum" est sélectionné
  bool isLoading = false;
  final TextEditingController minimumController = TextEditingController();
  final TextEditingController maximumController = TextEditingController();
  final int totalPages = 7; // Nombre total de pages

  // Méthode pour passer à la page suivante
  void _goToNextPage() {
    if (minimumController.text.isNotEmpty ||
        maximumController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => My_7th_question()),
      );
    }
  }

  // Méthode pour revenir à la page précédente
  void _goBack2ndPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_5th_question()),
    );
  }

      Future<void> _submitAnswer(String answer) async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await APIService.submitAnswer(1, 23, answer,
          'handle_questions', 'null'); // Example: client_id = 1, question_id = 1
      if (result["success"]) {
        // Navigate to the next question on success
        _goToNextPage();
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
      final result = await APIService.deleteAnswer(1, 22,
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
                      "What is your preferred pay range?",
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
              // Liste des boutons
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Bouton Minimum
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMinimumSelected = !isMinimumSelected;
                          });
                        },
                        child: Container(
                          width: 318,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFBFD7E4).withOpacity(0.5),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Minimum",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Formulaire Minimum
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                isMinimumSelected ? Colors.blue : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: minimumController,
                          keyboardType:
                              TextInputType.number, // Clavier numérique
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Accepte uniquement des chiffres
                          ],
                          onChanged: (value) {
                            setState(() {}); // Met à jour l'UI
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                    ),
                    // Bouton Maximum
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMaximumSelected = !isMaximumSelected;
                          });
                        },
                        child: Container(
                          width: 318,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFBFD7E4).withOpacity(0.5),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Maximum",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Formulaire Maximum
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                isMaximumSelected ? Colors.blue : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: maximumController,
                          keyboardType:
                              TextInputType.number, // Clavier numérique
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Accepte uniquement des chiffres
                          ],
                          onChanged: (value) {
                            setState(() {}); // Met à jour l'UI
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bouton "Back"
              Positioned(
                bottom: 55,
                left: 20,
                child: ElevatedButton(
                  onPressed: _goBack2ndPage,
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
                        color: index < 6
                            ? const Color.fromARGB(255, 73, 255, 79)
                            : const Color.fromARGB(255, 7, 27, 139)
                                .withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              ),
              // Bouton "Next" (visible uniquement si l'un des formulaires a une entrée)
              Positioned(
                bottom: 55,
                right: 20,
                child: ElevatedButton(
                  onPressed: (minimumController.text.isNotEmpty &&
                          maximumController.text.isNotEmpty)
                      ? _goToNextPage
                      : null, // Désactivé si aucun formulaire n'est rempli
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (minimumController.text.isNotEmpty ||
                            maximumController.text.isNotEmpty)
                        ? Colors.black
                        : Colors.grey,
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
            ],
          ),
        ),
      ),
    );
  }
}
