import 'package:flutter/material.dart';

class Custombox extends StatelessWidget {
  final Color bordercolor;
  final String title;
  const Custombox({super.key, required this.bordercolor, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 150,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: bordercolor),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.purple),
          textAlign: TextAlign.center, // Center the text
        ),
      ),
    );
  }
}
