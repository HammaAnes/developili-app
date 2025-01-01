import 'package:flutter/material.dart';
import '../couleur_du_fond.dart';
import 'Form_client_qst2.dart';
import '../main_client.dart';
import '../api_service.dart'; // Import the API service

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: My_1st_question(),
    );
  }
}

class My_1st_question extends StatefulWidget {
  @override
  _My_1st_question_State createState() => _My_1st_question_State();
}

class _My_1st_question_State extends State<My_1st_question>
    with TickerProviderStateMixin {
  int? boutonSelectionne; // Index of the selected button
  bool showForm = false; // Controls the display of the input form
  bool isLoading = false; // Loading indicator
  int currentPage = 0; // Current page index
  final int totalPages = 8; // Total number of pages

  final List<String> nomsBoutons = [
    'Entrepreneur',
    'Marketing Manager',
    'Technical Manager',
    'Project Manager',
    'Other (please specify)',
  ];

  final TextEditingController otherController = TextEditingController();

  // Submit the selected answer to the backend
  Future<void> _submitAnswer(String answer) async {
    setState(() {
      isLoading = true;
    });

    if (showForm && otherController.text.isNotEmpty) {
      answer = otherController.text;
    }

    try {
      final result = await APIService.submitAnswer(
        1,
        1,
        answer,
        'handle_questions',
      );

      if (result["success"]) {
        // Navigate to the next question on success
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => My_2nd_question()),
        );
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

  // Handles button selection and form display
  void _onOptionSelected(int index) {
    setState(() {
      boutonSelectionne = index;
      showForm =
          index == nomsBoutons.length - 1; // Show form for the "Other" option
      if (!showForm) {
        _submitAnswer(nomsBoutons[index]);
      }
    });
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
              // Title
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
              // Main question
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "What is your role in your organization?",
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
              // Button list
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(nomsBoutons.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () => _onOptionSelected(index),
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
                            child: index == nomsBoutons.length - 1
                                ? RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Other ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '(please specify)',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
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
                    // Input form for "Other" option
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: showForm
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
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
              // Loading indicator
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              // Back button
              Positioned(
                bottom: 55,
                left: 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
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
              // Next button
              if (showForm)
                Positioned(
                  bottom: 55,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: otherController.text.isNotEmpty
                        ? () => _submitAnswer(otherController.text)
                        : null, // Disabled if the form is empty
                    style: ElevatedButton.styleFrom(
                      backgroundColor: otherController.text.isNotEmpty
                          ? Colors.black
                          : Colors.grey, // Change color dynamically
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
