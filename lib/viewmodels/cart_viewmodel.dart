import 'package:flutter/foundation.dart';
<<<<<<< HEAD
import '../models/cart_item.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class CartViewModel extends ChangeNotifier {
  final _orderService = OrderService();
=======
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartViewModel extends ChangeNotifier {
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

<<<<<<< HEAD
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
=======
  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  double get deliveryFee => subtotal > 5000 ? 0 : 350;
  double get total => subtotal + deliveryFee;

  String get formattedSubtotal => 'Rs. ${subtotal.toStringAsFixed(0)}';
  String get formattedDelivery =>
      deliveryFee == 0 ? 'FREE' : 'Rs. ${deliveryFee.toStringAsFixed(0)}';
  String get formattedTotal => 'Rs. ${total.toStringAsFixed(0)}';

  void addItem(Product product, String size, String color) {
<<<<<<< HEAD
    final idx = _items.indexWhere((item) =>
        item.id == product.id &&
        item.selectedSize == size &&
        item.selectedColor == color);

    if (idx >= 0) {
      _items[idx].quantity++;
    } else {
      _items.add(CartItem(
        product: product,
        id: product.id,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
=======
    final existingIndex = _items.indexWhere((item) =>
        item.product.id == product.id &&
        item.selectedSize == size &&
        item.selectedColor == color);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        product: product,
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
        selectedSize: size,
        selectedColor: color,
      ));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeItem(index);
    } else {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

<<<<<<< HEAD
  bool containsProduct(String productId) =>
      _items.any((item) => item.product.id == productId);

  // ── Place order → save to Firestore ──────────────────────────────────────
  Future<String?> placeOrder({
    required String userId,
    required String name,
    required String phone,
    required String address,
    required String city,
    required String paymentMethod,
  }) async {
    try {
      final order = OrderModel(
        id: '',
        userId: userId,
        items: _items
            .map((item) => OrderItem(
                  productId: item.product.id,
                  productName: item.product.name,
                  imageUrl: item.product.imageUrl,
                  price: item.product.price,
                  quantity: item.quantity,
                  size: item.selectedSize,
                  color: item.selectedColor,
                ))
            .toList(),
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        total: total,
        deliveryName: name,
        deliveryPhone: phone,
        deliveryAddress: address,
        deliveryCity: city,
        paymentMethod: paymentMethod,
        createdAt: DateTime.now(),
      );

      final orderId = await _orderService.placeOrder(order);
      clear(); // empty cart after successful order
      return orderId;
    } catch (e) {
      return null;
    }
=======
  bool containsProduct(String productId) {
    return _items.any((item) => item.product.id == productId);
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  }
}
