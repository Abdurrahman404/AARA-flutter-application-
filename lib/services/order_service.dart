import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;

  // ── Place a new order ─────────────────────────────────────────────────────
  Future<String> placeOrder(OrderModel order) async {
    final docRef = await _db.collection('orders').add(order.toMap());
    return docRef.id;
  }

  // ── Fetch all orders for a user, newest first ─────────────────────────────
  Future<List<OrderModel>> getUserOrders(String userId) async {
    final snap = await _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snap.docs
        .map((doc) => OrderModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  // ── Real-time stream of user orders (optional — for orders screen) ─────────
  Stream<List<OrderModel>> ordersStream(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => OrderModel.fromMap(doc.id, doc.data()))
            .toList());
  }
}
