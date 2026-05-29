import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // ── Getters (same API your existing screens already use) ──────────────────
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  AuthViewModel() {
    // Listen to Firebase auth state — auto-restores session on app restart
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _currentUser = null;
    } else {
      // Re-fetch from Firestore so we always have fresh profile data
      _currentUser = await _authService.fetchUser(firebaseUser.uid);
    }
    notifyListeners();
  }

  // ── Email Login ───────────────────────────────────────────────────────────
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _authService.loginWithEmail(
        email: email,
        password: password,
      );
      _errorMessage = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ── Email Register ────────────────────────────────────────────────────────
  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _authService.registerWithEmail(
        name: name,
        email: email,
        password: password,
      );
      _errorMessage = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ── Google Sign-In ────────────────────────────────────────────────────────
  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    try {
      _currentUser = await _authService.signInWithGoogle();
      _errorMessage = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ── Password Reset ────────────────────────────────────────────────────────
  Future<bool> sendPasswordReset(String email) async {
    _setLoading(true);
    try {
      await _authService.sendPasswordReset(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ── Update Profile (same signature your ProfileScreen already calls) ──────
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
    required String city,
  }) async {
    if (_currentUser == null) return;
    _setLoading(true);
    try {
      _currentUser = await _authService.updateProfile(
        uid: _currentUser!.id,
        name: name,
        phone: phone,
        address: address,
        city: city,
      );
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  // ── Logout ────────────────────────────────────────────────────────────────
  void logout() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
