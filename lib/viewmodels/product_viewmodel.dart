import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
<<<<<<< HEAD
import '../services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final _service = ProductService();

=======

class ProductViewModel extends ChangeNotifier {
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  List<Product> _allProducts = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String? _sortBy;
<<<<<<< HEAD
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4

  List<Product> get filteredProducts {
    List<Product> result = List.from(_allProducts);

    if (_selectedCategory == 'New Arrivals') {
      result = result.where((p) => p.isNew).toList();
    } else if (_selectedCategory == 'Sale') {
      result = result.where((p) => p.hasDiscount).toList();
    } else if (_selectedCategory != 'All') {
      result = result.where((p) => p.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q))
          .toList();
    }

    if (_sortBy == 'price_asc') {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'price_desc') {
      result.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return result;
  }

  List<Product> get featuredProducts =>
      _allProducts.where((p) => p.isFeatured).toList();

  List<Product> get newArrivals =>
      _allProducts.where((p) => p.isNew).toList();

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

<<<<<<< HEAD
  // ── Initialize: seed Firestore if empty, then load ───────────────────────
  Future<void> initialize({bool forceRefresh = false}) async {
    if (_allProducts.isNotEmpty && !forceRefresh) return; // already loaded
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service.seedProducts();
      _allProducts = await _service.fetchProducts();
    } catch (e) {
      _error = e.toString();
      // Fallback to local data so the UI still works if Firestore fails
      _allProducts = ProductData.allProducts;
    }

    _isLoading = false;
=======
  void initialize() {
    _allProducts = ProductData.allProducts;
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSortBy(String? sort) {
    _sortBy = sort;
    notifyListeners();
  }
<<<<<<< HEAD

  void clearFilters() {
    _selectedCategory = 'All';
    _searchQuery = '';
    _sortBy = null;
    notifyListeners();
  }
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
}
