import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:noob_chat/models/user.dart';
import 'package:noob_chat/repositories/auth/auth_exceptions.dart';

/// Interface for user authentication
class AuthRepository {
  /// {@macro auth_repository}
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  ///
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// get the current whenever the auth state changes
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser == null ? User.empty : firebaseUser.toUser;

        return user;
      },
    );
  }

  /// returens the current user object
  User get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? User.empty;
  }

  /// Create new user account
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordException();
    }
  }

  /// Signs in the user with the provided [email] and [password]
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const LoginWithEmailAndPasswordException();
    }
  }

  /// Signs out a user
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

///
extension FirebaseUserX on firebase_auth.User {
  ///
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
      imageUrl: photoURL,
    );
  }
}
