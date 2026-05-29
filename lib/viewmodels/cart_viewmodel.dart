import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class CartViewModel extends ChangeNotifier {
  final _orderService = OrderService();
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => subtotal > 5000 ? 0 : 350;
  double get total => subtotal + deliveryFee;

  String get formattedSubtotal => 'Rs. ${subtotal.toStringAsFixed(0)}';
  String get formattedDelivery =>
      deliveryFee == 0 ? 'FREE' : 'Rs. ${deliveryFee.toStringAsFixed(0)}';
  String get formattedTotal => 'Rs. ${total.toStringAsFixed(0)}';

  void addItem(Product product, String size, String color) {
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
  }
}
