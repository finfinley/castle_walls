import 'package:atproto/atproto.dart' as atp;
import 'package:atproto/core.dart';
import 'package:bluesky/bluesky.dart';
import 'package:castle_walls/data_objects/user.dart';
import 'package:flutter/material.dart';

class BlueskyProvider extends ChangeNotifier {
  Bluesky? _bsky;
  User? _user;
  XRPCResponse<Session>? _session;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  Bluesky? get bsky => _bsky;
  User? get user => _user;
  XRPCResponse<Session>? get session => _session;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    try {
      _isLoading = true;
      _session = await atp.createSession(
        identifier: username,
        password: password,
      );
      if (session != null) {
        _bsky = Bluesky.fromSession(session!.data);
        _isLoggedIn = true;
        _user = User.fromSessionData(session!.data);

        notifyListeners();
        print(session!.data);
        print('Logged in!');
      }
    } catch (e) {
      print('Login failed: $e');
    }
    _isLoading = false;
  }

  Future<void> logout() async {
    _session = null;
    _bsky = null;
    _isLoggedIn = false;
    _user = null;

    notifyListeners();
  }
}
