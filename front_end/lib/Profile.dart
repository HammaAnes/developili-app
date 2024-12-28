import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors and styles (adjust as needed)
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
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top back arrow and "Profile" title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
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

                  // Row with profile image, name on top and details below
                  Center(
                    child: Column(
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Colors.purple.shade100, // Placeholder
                          // backgroundImage: AssetImage('assets/profile.jpg'), // If you have an asset
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

                  const SizedBox(height: 20),

                  // Profession / Experience / Company / Availability
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column of labels
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoLabel("Profession", labelStyle),
                            const SizedBox(height: 8),
                            _infoLabel("Experience", labelStyle),
                            const SizedBox(height: 8),
                            _infoLabel("Company", labelStyle),
                            const SizedBox(height: 8),
                            _infoLabel("Availability", labelStyle),
                          ],
                        ),
                      ),
                      // Right column of values
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Front-end | Designer | Back-end",
                                style: infoStyle),
                            const SizedBox(height: 8),
                            Text("Senior | 5 Years", style: infoStyle),
                            const SizedBox(height: 8),
                            Text("Facebook", style: infoStyle),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Switch(
                                  value: false,
                                  onChanged: (val) {},
                                  activeColor: Colors.blue,
                                  activeTrackColor: Colors.blueGrey[100],
                                ),
                                Text("Occupied", style: infoStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Accomplished Projects",
                    style: labelStyle.copyWith(
                      color: Colors.blue.shade900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Projects Scroll
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _projectCard("Devlopili", "Design"),
                        _projectCard("Facebook", "Front-end\nBack-end"),
                        _projectCard("Créneau", "Back-end\nDesign"),
                        _projectCard("Voyager", "Design\nFront-end"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Indicator dots (optional)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(true),
                      const SizedBox(width: 8),
                      _dot(false),
                      const SizedBox(width: 8),
                      _dot(false),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Bottom section with rating, projects, pay range, etc.
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                                Text("(negotiable)",
                                    style: infoStyle.copyWith(fontSize: 12)),
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

                  // If you are overflowing, try removing or reducing this bottom SizedBox.
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoLabel(String text, TextStyle style) {
    return Text(text, style: style.copyWith(color: Colors.white));
  }

  Widget _projectCard(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      width: 120,
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
