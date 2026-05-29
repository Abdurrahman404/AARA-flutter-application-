import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case 'confirmed':
        return AppColors.accent;
      case 'shipped':
        return const Color(0xFF1565C0);
      case 'delivered':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textLight;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle_outline;
      case 'shipped':
        return Icons.local_shipping_outlined;
      case 'delivered':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.hourglass_empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthViewModel>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: user == null
          ? _buildNotSignedIn(context)
          : StreamBuilder<List<OrderModel>>(
              stream: OrderService().ordersStream(user.id),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.accent),
                  );
                }
                if (snap.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: AppColors.error),
                        const SizedBox(height: 12),
                        Text('Failed to load orders',
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  );
                }
                final orders = snap.data ?? [];
                if (orders.isEmpty) return _buildEmpty(context);
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (ctx, i) => _buildOrderCard(context, orders[i]),
                );
              },
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    final statusColor = _statusColor(order.status);
    final statusIcon = _statusIcon(order.status);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.id.substring(0, 8).toUpperCase()}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.formattedDate,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 13, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        order.status[0].toUpperCase() +
                            order.status.substring(1),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          // Items
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Column(
              children: order.items.take(2).map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.imageUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 48,
                            height: 48,
                            color: AppColors.cardBg,
                            child: const Icon(Icons.image_not_supported_outlined,
                                size: 20, color: AppColors.textLight),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textDark,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Size: ${item.size}  ·  Qty: ${item.quantity}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Rs. ${(item.price * item.quantity).toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          if (order.items.length > 2)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                '+${order.items.length - 2} more item(s)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.accent,
                    ),
              ),
            ),
          const Divider(height: 1, color: AppColors.divider),
          // Footer
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(
                      order.formattedTotal,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.accent,
                          ),
                    ),
                  ],
                ),
                Text(
                  order.paymentMethod,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMid,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined,
              size: 72, color: AppColors.divider),
          const SizedBox(height: 16),
          Text('No orders yet',
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 8),
          Text('Your order history will appear here',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.productListing),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotSignedIn(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off_outlined,
              size: 60, color: AppColors.textLight),
          const SizedBox(height: 16),
          Text('Not signed in',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.login),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
