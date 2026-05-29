import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> _stream(String uid) {
    return _db
        .collection('notifications')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> _markRead(String docId) async {
    await _db.collection('notifications').doc(docId).update({'read': true});
  }

  Future<void> _markAllRead(String uid) async {
    final batch = _db.batch();
    final snap = await _db
        .collection('notifications')
        .where('userId', isEqualTo: uid)
        .where('read', isEqualTo: false)
        .get();
    for (final doc in snap.docs) {
      batch.update(doc.reference, {'read': true});
    }
    await batch.commit();
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'promo':
        return Icons.local_offer_outlined;
      case 'delivery':
        return Icons.local_shipping_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _colorFor(String type) {
    switch (type) {
      case 'order':
        return AppColors.accent;
      case 'promo':
        return const Color(0xFF7B61FF);
      case 'delivery':
        return const Color(0xFF1565C0);
      default:
        return AppColors.textMid;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthViewModel>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (user != null)
            TextButton(
              onPressed: () => _markAllRead(user.id),
              child: const Text('Mark all read',
                  style: TextStyle(
                      color: AppColors.accent, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      body: user == null
          ? Center(
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: const Text('Sign In'),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _stream(user.id),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.accent));
                }
                final docs = snap.data?.docs ?? [];
                if (docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.notifications_off_outlined,
                            size: 72, color: AppColors.divider),
                        const SizedBox(height: 16),
                        Text('No notifications yet',
                            style:
                                Theme.of(context).textTheme.displaySmall),
                        const SizedBox(height: 8),
                        Text(
                            "We'll notify you about orders, promos & more",
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (ctx, i) {
                    final doc = docs[i];
                    final data = doc.data() as Map<String, dynamic>;
                    final read = data['read'] == true;
                    final type = data['type'] as String? ?? 'general';
                    final icon = _iconFor(type);
                    final color = _colorFor(type);
                    final ts = data['createdAt'];
                    String timeStr = '';
                    if (ts is Timestamp) {
                      final dt = ts.toDate();
                      final now = DateTime.now();
                      final diff = now.difference(dt);
                      if (diff.inMinutes < 60) {
                        timeStr = '${diff.inMinutes}m ago';
                      } else if (diff.inHours < 24) {
                        timeStr = '${diff.inHours}h ago';
                      } else {
                        timeStr = '${diff.inDays}d ago';
                      }
                    }
                    return GestureDetector(
                      onTap: () {
                        if (!read) _markRead(doc.id);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: read
                              ? AppColors.surface
                              : AppColors.accent.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: read
                                ? AppColors.divider
                                : AppColors.accent.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(icon, size: 20, color: color),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data['title'] as String? ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: read
                                                    ? FontWeight.w500
                                                    : FontWeight.w700,
                                              ),
                                        ),
                                      ),
                                      if (!read)
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: AppColors.accent,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    data['body'] as String? ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.textMid,
                                        ),
                                  ),
                                  if (timeStr.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(timeStr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.textLight,
                                              fontSize: 11,
                                            )),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
