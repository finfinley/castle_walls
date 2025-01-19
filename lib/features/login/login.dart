import 'dart:async';

import 'package:castle_walls/providers/bluesky_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:atproto/atproto.dart' as atp;
import 'package:bluesky/bluesky.dart' as bsky;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final session = await atp.createSession(
          identifier: _usernameController.value.text,
          password: _passwordController.value.text);
      final bluesky = bsky.Bluesky.fromSession(session.data);
    } catch (e) {
      print('Login failed: $e');
    }
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
                SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: GoogleFonts.pressStart2p(),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.pressStart2p(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                RetroButton(
                    onPressed: () async {
                      final provider =
                          Provider.of<BlueskyProvider>(context, listen: false);
                      await provider.login(_usernameController.value.text,
                          _passwordController.value.text);
                    },
                    text: 'Login')
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
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple
  ];
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _isLoggedIn = Provider.of<BlueskyProvider>(context).isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    final bsky = Provider.of<BlueskyProvider>(context);
    final isLoggedIn = bsky.isLoggedIn;
    final user = bsky.user;

    return AnimatedDefaultTextStyle(
      duration: Duration(seconds: 3),
      style: GoogleFonts.metalMania(
        color: _colors[_currentColorIndex],
        fontSize: 32,
      ),
      child: Text(
        isLoggedIn ? "Welcome to the Castle, ${user!.email}." : _text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
