import 'package:flutter/material.dart';

class UserReport extends StatefulWidget {
  const UserReport({super.key});

  @override
  State<UserReport> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          // You can add actions here if needed
        ],
      ),
      body: Center(
        child: Text('Welcome to User Home!'),
      ),
    );
  }
}
