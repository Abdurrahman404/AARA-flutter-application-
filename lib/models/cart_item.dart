import 'package:aara/models/product_model.dart';

class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  int quantity;
  final String selectedSize;
  final String selectedColor;
  final Product product;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
    required this.selectedSize,
    required this.selectedColor,
    required this.product,
  });

  double get totalPrice => price * quantity;

  String get formattedPrice => 'Rs. ${price.toStringAsFixed(2)}';
}