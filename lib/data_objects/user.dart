import 'package:atproto/core.dart';

class User {
  final String handle;
  final String? email;

  User({required this.handle, required this.email});

  factory User.fromSessionData(Session data) {
    return User(email: data.email, handle: data.handle);
  }
}
