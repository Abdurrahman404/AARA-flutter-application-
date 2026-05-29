class OrderItem {
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  final int quantity;
  final String size;
  final String color;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.size,
    required this.color,
  });

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'productName': productName,
        'imageUrl': imageUrl,
        'price': price,
        'quantity': quantity,
        'size': size,
        'color': color,
      };

  factory OrderItem.fromMap(Map<String, dynamic> m) => OrderItem(
        productId: m['productId'] ?? '',
        productName: m['productName'] ?? '',
        imageUrl: m['imageUrl'] ?? '',
        price: (m['price'] ?? 0).toDouble(),
        quantity: m['quantity'] ?? 1,
        size: m['size'] ?? '',
        color: m['color'] ?? '',
      );
}

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String deliveryName;
  final String deliveryPhone;
  final String deliveryAddress;
  final String deliveryCity;
  final String paymentMethod;
  final String status; // pending | confirmed | shipped | delivered
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.deliveryName,
    required this.deliveryPhone,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.paymentMethod,
    this.status = 'pending',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'items': items.map((i) => i.toMap()).toList(),
        'subtotal': subtotal,
        'deliveryFee': deliveryFee,
        'total': total,
        'deliveryName': deliveryName,
        'deliveryPhone': deliveryPhone,
        'deliveryAddress': deliveryAddress,
        'deliveryCity': deliveryCity,
        'paymentMethod': paymentMethod,
        'status': status,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };

  factory OrderModel.fromMap(String id, Map<String, dynamic> m) => OrderModel(
        id: id,
        userId: m['userId'] ?? '',
        items: (m['items'] as List<dynamic>? ?? [])
            .map((i) => OrderItem.fromMap(i as Map<String, dynamic>))
            .toList(),
        subtotal: (m['subtotal'] ?? 0).toDouble(),
        deliveryFee: (m['deliveryFee'] ?? 0).toDouble(),
        total: (m['total'] ?? 0).toDouble(),
        deliveryName: m['deliveryName'] ?? '',
        deliveryPhone: m['deliveryPhone'] ?? '',
        deliveryAddress: m['deliveryAddress'] ?? '',
        deliveryCity: m['deliveryCity'] ?? '',
        paymentMethod: m['paymentMethod'] ?? '',
        status: m['status'] ?? 'pending',
        createdAt: m['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(m['createdAt'])
            : DateTime.now(),
      );

  String get formattedTotal => 'Rs. ${total.toStringAsFixed(0)}';
  String get formattedDate =>
      '${createdAt.day}/${createdAt.month}/${createdAt.year}';
}
