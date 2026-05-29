import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../viewmodels/wishlist_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../models/product_model.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<WishlistViewModel>(
        builder: (ctx, wishlist, _) {
          if (wishlist.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border,
                      size: 72, color: AppColors.divider),
                  const SizedBox(height: 16),
                  Text('Your wishlist is empty',
                      style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text('Save items you love here',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.productListing),
                    child: const Text('Browse Products'),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: wishlist.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) {
              final product = wishlist.items[i];
              return _WishlistCard(product: product);
            },
          );
        },
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final Product product;
  const _WishlistCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          // Image
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail,
                arguments: product),
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                width: 100,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(width: 100, height: 120, color: AppColors.cardBg),
                errorWidget: (_, __, ___) => Container(
                  width: 100,
                  height: 120,
                  color: AppColors.cardBg,
                  child: const Icon(Icons.image_not_supported_outlined,
                      color: AppColors.textLight),
                ),
              ),
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.formattedPrice,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textDark,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartViewModel>().addItem(
                                    product,
                                    product.sizes.isNotEmpty
                                        ? product.sizes.first
                                        : '',
                                    product.colors.isNotEmpty
                                        ? product.colors.first
                                        : '',
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Added to cart'),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              textStyle: const TextStyle(fontSize: 13),
                            ),
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () =>
                            context.read<WishlistViewModel>().remove(product.id),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.divider),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.delete_outline,
                              size: 18, color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
