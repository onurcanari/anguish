import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// Thrown when signing in anonymously process fails.
class SignInAnonymouslyException implements Exception {
  /// Creates a [SignInAnonymouslyException] object with given message.
  const SignInAnonymouslyException(this.message);

  /// A message describing the error.
  final String message;
}

/// Thrown when logout process fails.
class LogOutException implements Exception {
  /// Creates a [LogOutException] object with given message.
  const LogOutException(this.message);

  /// A message describing the error.
  final String message;
}

/// {@template authentication_repository}
/// Repository which manages user authentication using Firebase Authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({firebase_auth.FirebaseAuth? auth}) {
    _firebaseAuth = auth ?? firebase_auth.FirebaseAuth.instance;
  }

  late final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Notifies about changes to the user's state (such as sign-in or sign-out).
  ///
  /// If user not signed in it will return [User.empty]
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty() : firebaseUser.toUser;
    });
  }

  /// Logs in into the app as an anonymous user.
  ///
  /// Throws [SignInAnonymouslyException] when operation fails.
  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } catch (_) {
      throw const SignInAnonymouslyException('Log in failed.');
    }
  }

  /// Logs out from signed user.
  /// If successful, it also updates user stream listeners.
  /// Throws [LogOutException] when operation fails.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw const LogOutException('Log out failed.');
    }
  }
}

/// A user.
class User {
  /// Creates a [User] object with given id, name and photo.
  User({
    required this.id,
    this.name,
    this.photo,
  });

  factory User.empty() => User(id: '');

  /// User's id.
  String id;

  /// User's name.
  String? name;

  /// User's photo url.
  String? photo;
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, photo: photoURL);
  }
}
