import 'package:atproto/atproto.dart' as atp;
import 'package:bluesky/bluesky.dart';
import 'package:castle_walls/data_objects/user.dart';
import 'package:flutter/material.dart';

class BlueskyProvider extends ChangeNotifier {
  Bluesky? _bsky;
  bool _isLoggedIn = false;
  User? _user;

  Bluesky? get bsky => _bsky;
  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  Future<void> login(String username, String password) async {
    try {
      final session = await atp.createSession(
        identifier: username,
        password: password,
      );
      _bsky = Bluesky.fromSession(session.data);
      _isLoggedIn = true;
      _user = User.fromSessionData(session.data);

      notifyListeners();
      print(session.data);
      print('Logged in!');
    } catch (e) {
      print('Login failed: $e');
    }
  }
}
