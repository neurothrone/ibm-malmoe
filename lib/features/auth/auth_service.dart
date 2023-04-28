import 'package:firebase_auth/firebase_auth.dart';

enum FirebaseAuthError {
  // Values are based on Firebase Auth Exception codes
  weakPassword("weak-password"),
  emailAlreadyInUse("email-already-in-use"),
  userNotFound("user-not-found"),
  wrongPassword("wrong-password");

  const FirebaseAuthError(this.code);

  final String code;

  @override
  String toString() {
    switch (this) {
      case FirebaseAuthError.weakPassword:
        return "The password provided is too weak.";
      case FirebaseAuthError.emailAlreadyInUse:
        return "The account already exists for that email.";
      case FirebaseAuthError.userNotFound:
        return "No user found for that email.";
      case FirebaseAuthError.wrongPassword:
        return "Wrong password provided for that user.";
    }
  }
}

// TODO: Refactor to DI
class AuthService {
  // Private constructor: there should only be one instance of this class
  AuthService._();

  static final shared = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: do something with user or remove variable
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthError.weakPassword.code) {
        return FirebaseAuthError.weakPassword.toString();
      } else if (e.code == FirebaseAuthError.emailAlreadyInUse.code) {
        return FirebaseAuthError.emailAlreadyInUse.toString();
      }
    } catch (e) {
      return "Something went wrong during registration.";
    }

    return null;
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: do something with user or remove variable
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthError.userNotFound.code) {
        return FirebaseAuthError.userNotFound.toString();
      } else if (e.code == FirebaseAuthError.wrongPassword.code) {
        return FirebaseAuthError.wrongPassword.toString();
      }
    } catch (e) {
      return "Something went wrong during sign in.";
    }

    return null;
  }

  Future<void> signOut() async => await _auth.signOut();
}
