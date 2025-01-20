import 'package:castle_walls/common/providers/bluesky_provider.dart';
import 'package:castle_walls/common/widgets/animated_text_color.dart';
import 'package:castle_walls/common/widgets/retro_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
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
                AnimatedTextColor(text: 'Welcome to the Castle'),
                SizedBox(height: 16),
                RetroButton(
                    onPressed: () async {
                      final provider =
                          Provider.of<BlueskyProvider>(context, listen: false);
                      await provider.logout();
                    },
                    text: 'Leave'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
