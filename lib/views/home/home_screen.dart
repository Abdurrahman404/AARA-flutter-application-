import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart' as badges;
import '../../viewmodels/product_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/common_widgets.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBanner = 0;
  int _navIndex = 0;

  final List<Map<String, String>> _banners = [
    {
      'image':
          'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=800',
      'title': 'New Season',
      'subtitle': 'Elegant Essentials'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
      'title': 'Summer Edit',
      'subtitle': 'Curated for You'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800',
      'title': 'Sale Up to 40%',
      'subtitle': 'Selected Styles'
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'AARA',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              letterSpacing: 4,
            ),
          ),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 22),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.productListing),
          ),
          Consumer<CartViewModel>(
            builder: (ctx, cart, _) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: badges.Badge(
                showBadge: cart.itemCount > 0,
                badgeContent: Text(
                  '${cart.itemCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeStyle:
                    const badges.BadgeStyle(badgeColor: AppColors.accent),
                child: IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, size: 22),
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.cart),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBannerSlider(),
            const SizedBox(height: 28),
            _buildCategories(),
            const SizedBox(height: 28),
            SectionHeader(
              title: 'Featured',
              actionText: 'See All',
              onAction: () =>
                  Navigator.pushNamed(context, AppRoutes.productListing),
            ),
            const SizedBox(height: 16),
            _buildFeaturedProducts(),
            const SizedBox(height: 28),
            SectionHeader(
              title: 'New Arrivals',
              actionText: 'See All',
              onAction: () =>
                  Navigator.pushNamed(context, AppRoutes.productListing),
            ),
            const SizedBox(height: 16),
            _buildNewArrivals(),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            onPageChanged: (i, _) => setState(() => _currentBanner = i),
          ),
          items: _banners.map((banner) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    banner['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.cardBg,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner['subtitle']!,
                          style: GoogleFonts.dmSans(
                            color: Colors.white70,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          banner['title']!,
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners.asMap().entries.map((e) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBanner == e.key ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentBanner == e.key
                    ? AppColors.accent
                    : AppColors.divider,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.woman, 'label': 'Women'},
      {'icon': Icons.man, 'label': 'Men'},
      {'icon': Icons.watch, 'label': 'Accessories'},
      {'icon': Icons.local_offer_outlined, 'label': 'Sale'},
    ];
    return SizedBox(
      height: 90,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final cat = categories[i];
          return GestureDetector(
            onTap: () {
              context
                  .read<ProductViewModel>()
                  .selectCategory(cat['label'] as String);
              Navigator.pushNamed(context, AppRoutes.productListing);
            },
            child: Container(
              width: 72,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Icon(cat['icon'] as IconData,
                        color: AppColors.accent, size: 26),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat['label'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMid,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return Consumer<ProductViewModel>(
      builder: (ctx, vm, _) {
        final featured = vm.featuredProducts;
        return SizedBox(
          height: 300,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ProductCard(product: featured[i]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewArrivals() {
    return Consumer<ProductViewModel>(
      builder: (ctx, vm, _) {
        final newItems = vm.newArrivals;
        return SizedBox(
          height: 320,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: newItems.length,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ProductCard(product: newItems[i]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _navIndex,
      onTap: (i) {
        setState(() => _navIndex = i);
        if (i == 1) {
          Navigator.pushNamed(context, AppRoutes.productListing);
        } else if (i == 2)
          Navigator.pushNamed(context, AppRoutes.cart);
        else if (i == 3)
          Navigator.pushNamed(context, AppRoutes.profile);
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Shop'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile'),
      ],
    );
  }
}
