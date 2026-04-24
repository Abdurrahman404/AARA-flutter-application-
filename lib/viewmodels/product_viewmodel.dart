import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _allProducts = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String? _sortBy;

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

  void initialize() {
    _allProducts = ProductData.allProducts;
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
}
