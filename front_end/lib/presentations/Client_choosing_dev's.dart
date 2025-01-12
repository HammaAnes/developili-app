import 'package:flutter/material.dart';
import 'couleur_du_fond.dart';
import 'profile_client.dart'; // Import the profile page
import 'main_client.dart'; // Import the main.dart for navigation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ChooseDevPage(),
    );
  }
}

class ChooseDevPage extends StatefulWidget {
  const ChooseDevPage({super.key});

  @override
  State<ChooseDevPage> createState() => _ChooseDevPageState();
}

class _ChooseDevPageState extends State<ChooseDevPage> {
  final Map<String, bool> _invitationStatus =
      {}; // Tracks the state of each button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Choose Dev",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    // Front-End Section (Top Developers)
                    buildSectionTitle(context, "Top Developers"),
                    ...buildDevCards(context, [
                      {
                        "name": "Aihan Soysakal",
                        "image": "https://via.placeholder.com/100",
                        "rating": 4.4
                      },
                      {
                        "name": "Aarius Ciocirlan",
                        "image": "https://via.placeholder.com/100",
                        "rating": 4.4
                      },
                      {
                        "name": "Aosh Howard",
                        "image": "https://via.placeholder.com/100",
                        "rating": 4.4
                      },
                      {
                        "name": "Jason Kline",
                        "image": "https://via.placeholder.com/100",
                        "rating": 4.3
                      },
                      {
                        "name": "Elina Brown",
                        "image": "https://via.placeholder.com/100",
                        "rating": 4.5
                      },
                    ]),
                    const SizedBox(height: 16),

                    // Confirm Button at the End
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ClientMain()), // Navigate to HomePage from main.dart
                            (route) =>
                                false, // Removes all previous routes from the stack
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF314270),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final textPainter = TextPainter(
              text: TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textDirection: TextDirection.ltr,
            )..layout();
            final textWidth = textPainter.size.width;
            return Divider(
              thickness: 2,
              color: Colors.white,
              endIndent: constraints.maxWidth - textWidth,
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  List<Widget> buildDevCards(
      BuildContext context, List<Map<String, dynamic>> devs) {
    return devs.map((dev) {
      return buildDevCard(
        context,
        dev['name'],
        dev['image'],
        dev['rating'],
      );
    }).toList();
  }

  Widget buildDevCard(
      BuildContext context, String name, String imageUrl, double rating) {
    final isInvited = _invitationStatus[name] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Profile Image as Button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ProfilePage(), // Navigate to ProfilePage
                ),
              );
            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(width: 12),
          // Name and Rating
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfilePage(), // Navigate to ProfilePage
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Action Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _invitationStatus[name] = !isInvited;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isInvited
                  ? Colors.white
                  : const Color(0xFF314270), // Button color
              foregroundColor: isInvited
                  ? const Color(0xFF314270)
                  : Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(isInvited ? "Done" : "Invite"),
          ),
        ],
      ),
    );
  }
}
