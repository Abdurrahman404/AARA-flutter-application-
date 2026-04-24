import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

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
      return false;
    }
  }

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
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

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

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
