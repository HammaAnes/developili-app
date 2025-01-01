import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'couleur_du_fond.dart';
import 'profile_dev.dart'; // Profile Page
import 'main_dev.dart'; // Main Page

void main() {
  runApp(const ChatPageApp());
}

class ChatPageApp extends StatelessWidget {
  const ChatPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"message": "Hi! How can I help you?", "isSent": false},
    {"message": "I need more details about the project.", "isSent": true},
  ];

  void _sendMessage() {
    final String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({"message": text, "isSent": true});
      });
      _messageController.clear();

      // Simulate receiving a response after a delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _messages.add({
            "message": "Thank you for reaching out. Let me get back to you.",
            "isSent": false,
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CouleurDuFond.gradientBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Back Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainDev()),
                        );
                      },
                    ),
                    Center(
                      child: const Text(
                        "Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Chat Area
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ChatBubble(
                      message: message["message"],
                      isSent: message["isSent"],
                    );
                  },
                ),
              ),
              // Message Input
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: _sendMessage,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSent;

  const ChatBubble({required this.message, required this.isSent, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSent ? Colors.blue : Colors.grey.shade800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSent ? 16 : 0),
            topRight: Radius.circular(isSent ? 0 : 16),
            bottomLeft: const Radius.circular(16),
            bottomRight: const Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
