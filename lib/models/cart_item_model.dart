<<<<<<< HEAD
// TODO Implement this library.
=======
import 'product_model.dart';

class CartItem {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
  String get formattedTotal => 'Rs. ${totalPrice.toStringAsFixed(0)}';
}
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
