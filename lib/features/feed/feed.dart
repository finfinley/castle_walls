import 'package:castle_walls/common/providers/bluesky_provider.dart';
import 'package:castle_walls/common/widgets/loading_splash.dart';
import 'package:castle_walls/common/widgets/retro_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the feed when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlueskyProvider>(context, listen: false).fetchFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Further',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'Leave',
          ),
        ],
        selectedItemColor: Colors.grey[900],
        unselectedItemColor: Colors.red[900],
        selectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.metalMania().fontFamily,
          fontSize: 16,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.metalMania().fontFamily,
          fontSize: 16,
        ),
        onTap: (value) => value == 0
            ? Provider.of<BlueskyProvider>(context, listen: false).fetchFeed()
            : Provider.of<BlueskyProvider>(context, listen: false).logout(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<BlueskyProvider>(
              builder: (context, bsky, child) {
                if (bsky.isLoading) {
                  return LoadingSplash();
                } else if (bsky.feed.isEmpty) {
                  return Center(
                    child: Text(
                      'No posts to show',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: bsky.feed
                        .map((imageUrl) =>
                            Post(imageUrl: imageUrl.images[0].url))
                        .toList(),
                  );
                }
              },
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
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        Logger().e('Failed to load image: $error');
                        return Center(
                          child: Text(
                            'Failed to load image',
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        );
                      }, // Use BoxFit.cover if you want the image to cover the entire area
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
