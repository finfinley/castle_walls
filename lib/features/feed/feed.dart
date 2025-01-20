import 'package:castle_walls/common/providers/bluesky_provider.dart';
import 'package:castle_walls/common/widgets/animated_text_color.dart';
import 'package:castle_walls/common/widgets/retro_button.dart';
import 'package:flutter/material.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(25, (index) => Post()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  final double fontSize = 20;
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedTextColor(text: 'Welcome to the Castle'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RetroButton(
                  onPressed: () async {
                    final provider =
                        Provider.of<BlueskyProvider>(context, listen: false);
                    await provider.fetchFeed();
                  },
                  text: 'Go Further',
                  size: fontSize,
                ),
                RetroButton(
                  onPressed: () async {
                    final provider =
                        Provider.of<BlueskyProvider>(context, listen: false);
                    await provider.logout();
                  },
                  text: 'Leave',
                  size: fontSize,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
