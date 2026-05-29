import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../models/product_model.dart';
import '../../widgets/common_widgets.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<ProductViewModel>(
            builder: (ctx, vm, _) => IconButton(
              icon: const Icon(Icons.sort, size: 22),
              onPressed: () => _showSortSheet(context, vm),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilter(),
          Expanded(child: _buildProductGrid()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: TextField(
        controller: _searchCtrl,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
          suffixIcon: _searchCtrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textLight),
                  onPressed: () {
                    _searchCtrl.clear();
                    context.read<ProductViewModel>().search('');
                  },
                )
              : null,
        ),
        onChanged: (v) => context.read<ProductViewModel>().search(v),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Consumer<ProductViewModel>(
      builder: (ctx, vm, _) => SizedBox(
        height: 44,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: ProductData.categories.length,
          itemBuilder: (ctx, i) {
            final cat = ProductData.categories[i];
            final selected = vm.selectedCategory == cat;
            return GestureDetector(
              onTap: () => vm.selectCategory(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                      color:
                          selected ? AppColors.primary : AppColors.divider),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: selected ? Colors.white : AppColors.textMid,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Consumer<ProductViewModel>(
      builder: (ctx, vm, _) {
        final products = vm.filteredProducts;
        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 64, color: AppColors.textLight),
                const SizedBox(height: 16),
                Text('No products found',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.62,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, i) => ProductCard(product: products[i], width: double.infinity),
        );
      },
    );
  }

  void _showSortSheet(BuildContext context, ProductViewModel vm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sort By', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 16),
            ...[
              ('Default', null),
              ('Price: Low to High', 'price_asc'),
              ('Price: High to Low', 'price_desc'),
              ('Top Rated', 'rating'),
            ].map((s) => ListTile(
                  title: Text(s.$1),
                  onTap: () {
                    vm.setSortBy(s.$2);
                    Navigator.pop(ctx);
                  },
                  contentPadding: EdgeInsets.zero,
                )),
          ],
        ),
      ),
    );
  }
}
