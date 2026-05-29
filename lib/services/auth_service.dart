import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn();

  // ── Auth state stream (listened by AuthViewModel) ─────────────────────────
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Get current Firebase UID ──────────────────────────────────────────────
  String? get currentUid => _auth.currentUser?.uid;

  // ── Fetch UserModel from Firestore ────────────────────────────────────────
  Future<UserModel?> fetchUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(uid, doc.data()!);
  }

  // ── Save / merge user doc in Firestore ────────────────────────────────────
  Future<void> _saveUser(UserModel user) async {
    await _db
        .collection('users')
        .doc(user.id)
        .set(user.toMap(), SetOptions(merge: true));
  }

  // ── Email + Password Register ─────────────────────────────────────────────
  Future<UserModel> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await cred.user!.updateDisplayName(name);

      final user = UserModel(
        id: cred.user!.uid,
        name: name,
        email: email,
      );
      await _saveUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw _authError(e);
    }
  }

  // ── Email + Password Login ────────────────────────────────────────────────
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = cred.user!.uid;
      final user = await fetchUser(uid);
      // Fallback: create doc if missing (shouldn't happen normally)
      if (user == null) {
        final fallback = UserModel(
          id: uid,
          name: cred.user!.displayName ?? 'User',
          email: email,
        );
        await _saveUser(fallback);
        return fallback;
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw _authError(e);
    }
  }

  // ── Google Sign-In ────────────────────────────────────────────────────────
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) throw Exception('Sign-in cancelled');

      final googleAuth = await googleAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final cred = await _auth.signInWithCredential(credential);
      final firebaseUser = cred.user!;

      // If user already exists in Firestore, return that
      final existing = await fetchUser(firebaseUser.uid);
      if (existing != null) return existing;

      // New Google user — create Firestore doc
      final newUser = UserModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'User',
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL,
      );
      await _saveUser(newUser);
      return newUser;
    } on FirebaseAuthException catch (e) {
      throw _authError(e);
    }
  }

  // ── Password Reset ────────────────────────────────────────────────────────
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _authError(e);
    }
  }

  // ── Update Firestore profile fields ───────────────────────────────────────
  Future<UserModel> updateProfile({
    required String uid,
    required String name,
    required String phone,
    required String address,
    required String city,
  }) async {
    await _db.collection('users').doc(uid).update({
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
    });
    await _auth.currentUser?.updateDisplayName(name);
    final updated = await fetchUser(uid);
    return updated!;
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // ── Human-readable Firebase error messages ────────────────────────────────
  String _authError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}
