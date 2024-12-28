import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentPage = 0; // Keeps track of the currently visible project card

  @override
  Widget build(BuildContext context) {
    // Colors and styles
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
              // Top section with back button, profile image, name, and details
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button and profile title
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Profile image and details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image and Name
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.purple.shade100,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Saïd Benrahma",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Profession, Experience, Company, and Availability
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoLabel("Profession", labelStyle),
                              Text("Front-end | Designer | Back-end",
                                  style: infoStyle),
                              const SizedBox(height: 8),
                              _infoLabel("Experience", labelStyle),
                              Text("Senior | 5 Years", style: infoStyle),
                              const SizedBox(height: 8),
                              _infoLabel("Company", labelStyle),
                              Text("Facebook", style: infoStyle),
                              const SizedBox(height: 8),
                              _infoLabel("Availability", labelStyle),
                              Row(
                                children: [
                                  Switch(
                                    value: !isOccupied,
                                    onChanged: (val) {
                                      setState(() {
                                        isOccupied = !val;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey[100],
                                  ),
                                  Text(
                                    isOccupied ? "Occupied" : "Available",
                                    style: infoStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Center section with Accomplished Projects
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Accomplished Projects",
                        style: labelStyle.copyWith(
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Projects Scroll
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _projectCard("Devlopili", "Design",
                                  isFirst: true),
                              _projectCard("Facebook", "Front-end\nBack-end"),
                              _projectCard("Créneau", "Back-end\nDesign"),
                              _projectCard("Voyager", "Design\nFront-end",
                                  isLast: true),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Responsive dots
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _dot(true),
                          const SizedBox(width: 8),
                          _dot(false),
                          const SizedBox(width: 8),
                          _dot(false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Section
              Container(
                margin: const EdgeInsets.only(
                    left: 14, right: 14), // Margins for the container
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 20), // Top and bottom padding
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  // Ensures the content inside adapts to the container's margins
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16), // Inner content padding
                  child: Column(
                    children: [
                      // Top Row: Average Rating and Projects Completed
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statItem("4.3", "Average Rating"),
                          _statItem("37", "Projects Completed"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Middle Row: Pay Range and Ongoing Projects
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pay Range", style: labelStyle),
                              const SizedBox(height: 4),
                              Text("150€ - 2000€", style: infoStyle),
                              const SizedBox(height: 4),
                              Text(
                                "(negotiable)",
                                style: infoStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          _statItem("02", "Ongoing Projects"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Bottom Row: Position and Technologies
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Position", style: labelStyle),
                                const SizedBox(height: 4),
                                Text("Software Engineer", style: infoStyle),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Technologies", style: labelStyle),
                                const SizedBox(height: 4),
                                Text(
                                  "Python / Django\nC / C++ / C#\nReact / Node",
                                  style: infoStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
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

  // The _projectCard method
  Widget _projectCard(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(12),
      width: 150, // Fixed width for uniformity
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),s
        ],
      ),
    );
  }

  // The _dot method
  Widget _dot(bool isActive) {
    return Container(
      width: isActive ? 12 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

  Widget _infoLabel(String text, TextStyle style) {
    return Text(text, style: style.copyWith(color: Colors.white));
  }

  Widget _projectCard(String title, String subtitle,
      {bool isFirst = false, bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(
        left: isFirst ? 0 : 8,
        right: isLast ? 0 : 8,
      ),
      padding: const EdgeInsets.all(12),
      width: 140, // Uniform card size
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
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
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _dot(bool active) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white54,
        shape: BoxShape.circle,
      ),
    );
  }
}
