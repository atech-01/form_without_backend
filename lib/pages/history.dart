import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(child: Text("Coming Soon....")),
      ),
    );
  }
}
