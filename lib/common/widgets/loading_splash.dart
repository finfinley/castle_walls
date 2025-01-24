import 'package:flutter/material.dart';

class LoadingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/loading_sword.gif',
        width: 225, // Adjust the width as needed
        height: 225, // Adjust the height as needed
        fit: BoxFit.cover,
      ),
    );
  }
}
