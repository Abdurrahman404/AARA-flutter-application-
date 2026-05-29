import 'package:flutter/foundation.dart';
<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();

=======
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

<<<<<<< HEAD
  // ── Getters (same API your existing screens already use) ──────────────────
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

<<<<<<< HEAD
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
=======
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = UserModel(
        id: 'user_001',
        name: 'Aisha Fernando',
        email: email,
        phone: '077 123 4567',
        address: '45, Galle Road',
        city: 'Colombo 03',
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Invalid email or password.';
      _isLoading = false;
      notifyListeners();
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
      return false;
    }
  }

<<<<<<< HEAD
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
=======
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      _currentUser = UserModel(
        id: 'user_001',
        name: name,
        email: email,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Please fill all fields correctly.';
      _isLoading = false;
      notifyListeners();
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
      return false;
    }
  }

<<<<<<< HEAD
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
=======
  void logout() {
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
    _currentUser = null;
    notifyListeners();
  }

<<<<<<< HEAD
  // ── Helpers ───────────────────────────────────────────────────────────────
=======
  void updateProfile({
    required String name,
    required String phone,
    required String address,
    required String city,
  }) {
    if (_currentUser != null) {
      _currentUser!.name = name;
      _currentUser!.phone = phone;
      _currentUser!.address = address;
      _currentUser!.city = city;
      notifyListeners();
    }
  }

>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
<<<<<<< HEAD

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
}
