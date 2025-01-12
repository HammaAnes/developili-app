import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'Form_SRS_qst7.dart'; // Importez la page que vous souhaitez afficher après avoir cliqué sur un des premiers boutons
import 'Form_SRS_qst9.dart';
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
      home: My_8th_question(),
    );
  }
}

class My_8th_question extends StatefulWidget {
  @override
  _My_8th_question_State createState() => _My_8th_question_State();
}

class _My_8th_question_State extends State<My_8th_question>
    with TickerProviderStateMixin {
  int? boutonSelectionne; // Index du bouton sélectionné
  bool showForm = false; // Contrôle l'affichage du formulaire
  int currentPage = 7; // Page actuelle
  final int totalPages = 9; // Nombre total de pages
  final TextEditingController otherController = TextEditingController();
  bool isLoading = false; // Loading indicator

  final List<String> nomsBoutons = [
    "Enter your response",
  ];

  // Méthode pour passer à la page suivante
  void _goToNextPage() {
    if (otherController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => My_9th_question()),
      );
    }
  }

  // Méthode pour revenir à la page d'accueil
  void _goBack2ndPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => My_7th_question()),
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
      final result = await APIService.submitAnswer(id, 16, answer,
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
      final storage = FlutterSecureStorage();
      String? user_id = await storage.read(key: "user_id");
      int? id = getUserId(user_id);
      final result = await APIService.deleteAnswer(id, 15,'handle_questions'); // Replace with the actual client ID and question ID
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
                      "Describe Your Project Idea",
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
                    ...List.generate(nomsBoutons.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              boutonSelectionne = index;
                              showForm = index == nomsBoutons.length - 1;
                              if (!showForm) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => My_9th_question()),
                                );
                              }
                            });
                          },
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
                    // Formulaire animé
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: showForm
                          ? Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Container(
                                width: 318,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: otherController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
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
                  onPressed: otherController.text.isNotEmpty
                  ? ()=> _submitAnswer(otherController.text)
                  : _goToNextPage,
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
                        color: index < 8
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
