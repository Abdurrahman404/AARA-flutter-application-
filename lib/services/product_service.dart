import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final _db = FirebaseFirestore.instance;

  // ── Fetch all products once ───────────────────────────────────────────────
  Future<List<Product>> fetchProducts() async {
    final snap = await _db.collection('products').get();
    return snap.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()))
        .toList();
  }

  // ── Real-time stream ──────────────────────────────────────────────────────
  Stream<List<Product>> productsStream() {
    return _db.collection('products').snapshots().map(
          (snap) => snap.docs
              .map((doc) => Product.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  // ── Seed: checks if valid products exist (must have 'name' field) ─────────
  Future<void> seedProducts() async {
    // Check if at least one *valid* product doc exists (has 'name' field)
    final existing = await _db
        .collection('products')
        .where('name', isGreaterThan: '')
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) return; // already seeded correctly

    // Delete any bad/stale docs first
    final allDocs = await _db.collection('products').get();
    final deleteBatch = _db.batch();
    for (final doc in allDocs.docs) {
      deleteBatch.delete(doc.reference);
    }
    if (allDocs.docs.isNotEmpty) await deleteBatch.commit();

    // Write all 12 products
    final seedBatch = _db.batch();
    for (final product in ProductData.allProducts) {
      final ref = _db.collection('products').doc(product.id);
      seedBatch.set(ref, product.toMap());
    }
    await seedBatch.commit();
  }
}
