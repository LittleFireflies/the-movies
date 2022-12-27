import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<UserCredential> signInWithGoogle();
  Future<User?> getCurrentUser();
  Future<void> signOut();
}
