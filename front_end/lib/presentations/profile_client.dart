import 'package:flutter/material.dart';
import 'projects_page.dart'; // Import the Projects Page

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final Color leftGradientColor = const Color(0xFF26365A);
    final Color rightGradientColor = const Color(0xFF72C1D9);

    final TextStyle labelStyle = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    );

    final TextStyle infoStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    );

    final List<Map<String, String>> projects = [
      {"title": "Devlopili", "subtitle": "Design"},
      {"title": "Facebook", "subtitle": "Front-end\nBack-end"},
      {"title": "Créneau", "subtitle": "Back-end\nDesign"},
      {"title": "Voyager", "subtitle": "Design\nFront-end"},
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [leftGradientColor, rightGradientColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back Button and Profile Title
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Profile Image and Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.purple.shade100,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Saïd Benrahma",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Projects Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Projects",
                      style: labelStyle.copyWith(
                        color: Colors.blue.shade900,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Projects List
                    SizedBox(
                      height: 150, // Larger height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProjectsPage(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? 16 : 8,
                                right: index == projects.length - 1 ? 16 : 8,
                              ),
                              width: 150, // Larger width
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      projects[index]['title']!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      projects[index]['subtitle']!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Section
              Container(
                margin: const EdgeInsets.only(left: 14, right: 14),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF5693AD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Developers Worked With
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statItem("5", "Developers Worked With"),
                          _statItem("37", "Projects Completed"),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Total Spent
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Spent",
                                style: labelStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("4000€", style: infoStyle),
                            ],
                          ),
                          _statItem("02", "Ongoing Projects"),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Role Section Centered
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Role",
                              style: labelStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("Software Engineer", style: infoStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _infoLabel(String text, TextStyle style) {
    return Text(text, style: style.copyWith(color: Colors.white));
  }
}
