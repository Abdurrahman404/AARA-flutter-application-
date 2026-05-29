import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class WishlistViewModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;

  bool contains(String productId) => _items.any((p) => p.id == productId);

  void toggle(Product product) {
    final idx = _items.indexWhere((p) => p.id == product.id);
    if (idx >= 0) {
      _items.removeAt(idx);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
