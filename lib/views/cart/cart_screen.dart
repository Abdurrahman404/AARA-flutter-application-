import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<CartViewModel>(
            builder: (ctx, cart, _) => cart.items.isNotEmpty
                ? TextButton(
                    onPressed: () => _confirmClear(context, cart),
                    child: const Text('Clear',
                        style: TextStyle(color: AppColors.error)),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Consumer<CartViewModel>(
        builder: (ctx, cart, _) {
          if (cart.items.isEmpty) {
            return _buildEmpty(context);
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) =>
                      _buildCartItem(context, cart, i),
                ),
              ),
              _buildOrderSummary(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined,
              size: 80, color: AppColors.divider),
          const SizedBox(height: 20),
          Text('Your cart is empty',
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 8),
          Text('Add items to get started',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.productListing),
            child: const Text('Explore Products'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, CartViewModel cart, int index) {
    final item = cart.items[index];
    return Dismissible(
      key: Key('${item.product.id}_${item.selectedSize}_${item.selectedColor}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.error),
      ),
      onDismissed: (_) => cart.removeItem(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: item.product.imageUrl,
                width: 80,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.selectedSize} · ${item.selectedColor}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.product.formattedPrice,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Row(
                        children: [
                          _qtyBtn(
                            icon: Icons.remove,
                            onTap: () => cart.updateQuantity(
                                index, item.quantity - 1),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${item.quantity}',
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          _qtyBtn(
                            icon: Icons.add,
                            onTap: () => cart.updateQuantity(
                                index, item.quantity + 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, size: 14, color: AppColors.textDark),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartViewModel cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _summaryRow(context, 'Subtotal', cart.formattedSubtotal),
          const SizedBox(height: 8),
          _summaryRow(context, 'Delivery', cart.formattedDelivery,
              isGreen: cart.deliveryFee == 0),
          const Divider(height: 20, color: AppColors.divider),
          _summaryRow(context, 'Total', cart.formattedTotal,
              isTotal: true),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.checkout),
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value,
      {bool isTotal = false, bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isTotal
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: isTotal
              ? Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.accent,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isGreen ? AppColors.success : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
        ),
      ],
    );
  }

  void _confirmClear(BuildContext context, CartViewModel cart) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Remove all items from your cart?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              cart.clear();
              Navigator.pop(ctx);
            },
            child: const Text('Clear', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
