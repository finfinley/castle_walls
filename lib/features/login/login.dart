import 'dart:async';

import 'package:castle_walls/common/providers/bluesky_provider.dart';
import 'package:castle_walls/common/widgets/animated_text_color.dart';
import 'package:castle_walls/common/widgets/retro_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            child: Consumer<BlueskyProvider>(builder: (context, bsky, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedTextColor(
                    text: 'Enter the Castle',
                  ),
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
                  !bsky.isLoading
                      ? RetroButton(
                          onPressed: () async {
                            await bsky.login(_usernameController.value.text,
                                _passwordController.value.text);
                          },
                          isEnabled: !bsky.isLoading,
                          text: 'Login')
                      : Image.asset(
                          'assets/loading_sword.gif',
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
