import 'dart:async';

import 'package:castle_walls/common/providers/bluesky_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnimatedTextColor extends StatefulWidget {
  final String text;

  const AnimatedTextColor({Key? key, required this.text}) : super(key: key);

  @override
  _AnimatedTextColorState createState() => _AnimatedTextColorState();
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
    return AnimatedDefaultTextStyle(
      duration: Duration(seconds: 3),
      style: GoogleFonts.metalMania(
        color: _colors[_currentColorIndex],
        fontSize: 32,
      ),
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
