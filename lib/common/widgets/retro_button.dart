import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RetroButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isEnabled;

  RetroButton(
      {required this.onPressed, required this.text, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.black : Colors.grey,
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(
          text,
          style: GoogleFonts.metalMania(
            color: isEnabled ? Colors.white : Colors.black38,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
