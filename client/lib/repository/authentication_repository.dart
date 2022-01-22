import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationRepository {
  AuthenticationRepository(this._firebaseAuth);

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty() : firebaseUser.toUser;
    });
  }

  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } catch (_) {
      throw const LogInFailure('Log in failed.');
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw const LogOutFailure('Log out failed.');
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, photo: photoURL);
  }
}

class User {
  User({
    required this.id,
    this.name,
    this.photo,
  });
  factory User.empty() => User(id: '');

  String id;
  String? name;
  String? photo;
}

class LogInFailure implements Exception {
  const LogInFailure(this.message);

  final String message;
}

class LogOutFailure implements Exception {
  const LogOutFailure(this.message);

  final String message;
}
