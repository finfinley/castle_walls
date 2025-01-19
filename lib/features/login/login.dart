import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bluesky/bluesky.dart' as bsky;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  final blueSky = bsky.Bluesky.anonymous();
  log(blueSky.toString());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedTextColor(),
                // Text(
                //   'Enter the Castle',
                //   style: GoogleFonts.metalMania(
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: GoogleFonts.pressStart2p(),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.pressStart2p(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                RetroButton(onPressed: _login, text: 'Login')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RetroButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  RetroButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(
          text,
          style: GoogleFonts.metalMania(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}

class AnimatedTextColor extends StatefulWidget {
  @override
  State<AnimatedTextColor> createState() => _AnimatedTextColorState();
}

class _AnimatedTextColorState extends State<AnimatedTextColor> {
  final List<Color> _colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple];
  int _currentColorIndex = 0;
  late Timer _timer;
  final String _text = 'Enter the Castle';
  // final String _text;

  @override
  void initState() {
    super.initState();
    _startColorChange();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startColorChange() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: Duration(seconds: 3),
      style: GoogleFonts.metalMania(
        color: _colors[_currentColorIndex],
        fontSize: 40,
      ),
      child: Text(_text),
    );
  }
}
