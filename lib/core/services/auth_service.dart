import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sss/core/utils/exceptions/firebase_auth_exceptions.dart';

/// Firebase email auth + Firestore user document.
/// Signup: create user, then save profile in [users] collection.
class AuthService {
  AuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  static const String _usersCollection = 'users';

  /// Create account with email/password and save user doc to Firestore.
  /// Throws [MyFirebaseAuthException] on auth errors.
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String birthday,
  }) async {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty) {
      throw MyFirebaseAuthException('invalid-email');
    }
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: trimmedEmail,
      password: password,
    );
    final user = userCredential.user;
    if (user == null) return;
    await _saveUserDocument(
      uid: user.uid,
      email: trimmedEmail,
      username: username.trim(),
      birthday: birthday.trim(),
    );
  }

  /// Sign in with email and password.
  /// Throws [MyFirebaseAuthException] on auth errors.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty) {
      throw MyFirebaseAuthException('invalid-email');
    }
    await _auth.signInWithEmailAndPassword(
      email: trimmedEmail,
      password: password,
    );
  }

  /// Write or overwrite user profile in Firestore [users] collection.
  Future<void> _saveUserDocument({
    required String uid,
    required String email,
    required String username,
    required String birthday,
  }) async {
    await _firestore.collection(_usersCollection).doc(uid).set({
      'uid': uid,
      'email': email,
      'username': username,
      'birthday': birthday,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Current Firebase user (null if not signed in).
  User? get currentUser => _auth.currentUser;
}
