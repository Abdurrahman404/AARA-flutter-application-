import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'utils/app_theme.dart';
import 'utils/app_routes.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/wishlist_viewmodel.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
import 'views/auth/splash_screen.dart';
=======
import 'package:provider/provider.dart';

import 'utils/app_theme.dart';
import 'utils/app_routes.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';

import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
import 'views/home/home_screen.dart';
import 'views/product/product_listing_screen.dart';
import 'views/product/product_detail_screen.dart';
import 'views/cart/cart_screen.dart';
import 'views/checkout/checkout_screen.dart';
import 'views/checkout/order_success_screen.dart';
import 'views/profile/profile_screen.dart';
<<<<<<< HEAD
import 'views/profile/orders_screen.dart';
import 'views/profile/wishlist_screen.dart';
import 'views/profile/saved_addresses_screen.dart';
import 'views/profile/notifications_screen.dart';
import 'views/profile/help_support_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
=======

void main() {
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  runApp(const AaraApp());
}

class AaraApp extends StatelessWidget {
  const AaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
<<<<<<< HEAD
        ChangeNotifierProvider(create: (_) => WishlistViewModel()),
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
      ],
      child: MaterialApp(
        title: 'AARA Fashion',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
<<<<<<< HEAD
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (_) => const SplashScreen(),
=======
        initialRoute: AppRoutes.login,
        routes: {
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
          AppRoutes.login: (_) => const LoginScreen(),
          AppRoutes.register: (_) => const RegisterScreen(),
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.productListing: (_) => const ProductListingScreen(),
          AppRoutes.productDetail: (_) => const ProductDetailScreen(),
          AppRoutes.cart: (_) => const CartScreen(),
          AppRoutes.checkout: (_) => const CheckoutScreen(),
          AppRoutes.orderSuccess: (_) => const OrderSuccessScreen(),
          AppRoutes.profile: (_) => const ProfileScreen(),
<<<<<<< HEAD
          AppRoutes.orders: (_) => const OrdersScreen(),
          AppRoutes.wishlist: (_) => const WishlistScreen(),
          AppRoutes.savedAddresses: (_) => const SavedAddressesScreen(),
          AppRoutes.notifications: (_) => const NotificationsScreen(),
          AppRoutes.helpSupport: (_) => const HelpSupportScreen(),
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
        },
      ),
    );
  }
}
