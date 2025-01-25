import 'package:castle_walls/features/feed/feed.dart';
import 'package:flutter/material.dart';

class FramedPost extends StatelessWidget {
  final String imageUrl;

  const FramedPost({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Set a specific width
      height: 300, // Set a specific height
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/basic_frame.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Post(imageUrl: imageUrl),
          ),
        ],
      ),
    );
  }
}
