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

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      setLoading(true);
      _session = await atp.createSession(
        identifier: username,
        password: password,
      );
      if (session != null) {
        _bsky = Bluesky.fromSession(session!.data);
        _user = User.fromSessionData(session!.data);
        setLoggedIn(true);

        notifyListeners();
        print(session!.data);
        print('Logged in!');
      }
    } catch (e) {
      print('Login failed: $e');
    }
    setLoading(false);
  }

  Future<void> logout() async {
    _session = null;
    _bsky = null;
    _isLoggedIn = false;
    _user = null;

    notifyListeners();
  }

  Future<void> fetchFeed() async {
    try {
      setLoading(true);
      final uri = AtUri(
          'at://did:plc:bwdcpnl2rvlpr2ixlsnzx64s/app.bsky.feed.generator/aaadetmzvhdbw');
      final response = await bsky!.feed.getFeed(generatorUri: uri, limit: 1);
      final embed = response.data.feed.firstOrNull!.toJson()['post']['embed'];
      final List<String> imageUrls = embed['images']
          .map<String>((image) => image['fullsize'] as String)
          .toList();
      print(imageUrls);
    } catch (e) {
      print('Failed to fetch feed: $e');
    }
    setLoading(false);
  }
}
