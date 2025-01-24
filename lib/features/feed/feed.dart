import 'package:castle_walls/common/providers/bluesky_provider.dart';
import 'package:castle_walls/common/widgets/retro_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bsky = Provider.of<BlueskyProvider>(context, listen: false);
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
                children: bsky.feed
                    .map((imageUrl) => Post(imageUrl: imageUrl.images[0].url))
                    .toList(),
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
  final String imageUrl;
  const Post({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bsky = Provider.of<BlueskyProvider>(context, listen: false);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1, // Adjust the aspect ratio as needed
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit
                          .contain, // Use BoxFit.cover if you want the image to cover the entire area
                    ),
                  ),
                ),
                RetroButton(
                  onPressed: () async {
                    await bsky.fetchFeed();
                  },
                  text: 'Go Further',
                  size: fontSize,
                ),
                RetroButton(
                  onPressed: () async {
                    await bsky.logout();
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
