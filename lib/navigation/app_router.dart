import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/account_data.dart';
import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../screens/about_screen.dart';
import '../screens/address_edit_screen.dart';
import '../screens/address_screen.dart';
import '../screens/after_sale_screen.dart';
import '../screens/ai_recommend_screen.dart';
import '../screens/brand_story_screen.dart';
import '../screens/brewing_guide_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/category_screen.dart';
import '../screens/coupon_screen.dart';
import '../screens/customer_service_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/footprint_screen.dart';
import '../screens/gift_customize_screen.dart';
import '../screens/home_screen.dart';
import '../screens/logistics_screen.dart';
import '../screens/login_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/order_confirm_screen.dart';
import '../screens/order_list_screen.dart';
import '../screens/payment_screen.dart';
import '../screens/payment_success_screen.dart';
import '../screens/points_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reviews_screen.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/solar_term_screen.dart';
import '../screens/tea_culture_screen.dart';
import '../screens/tea_region_screen.dart';
import '../screens/tea_space_screen.dart';
import '../state/app_state.dart';

class AppRoutes {
  AppRoutes._();

  static const home = 'home';
  static const category = 'category';
  static const culture = 'culture';
  static const cart = 'cart';
  static const profile = 'profile';
  static const product = 'product';
  static const search = 'search';
  static const login = 'login';
  static const settings = 'settings';
  static const favorites = 'favorites';
  static const coupons = 'coupons';
  static const orders = 'orders';
  static const orderConfirm = 'orderConfirm';
  static const payment = 'payment';
  static const paymentSuccess = 'paymentSuccess';
  static const logistics = 'logistics';
  static const reviews = 'reviews';
  static const notifications = 'notifications';
  static const brewing = 'brewing';
  static const aiRecommend = 'aiRecommend';
  static const giftCustomize = 'giftCustomize';
  static const solarTerms = 'solarTerms';
  static const teaSpace = 'teaSpace';
  static const teaRegion = 'teaRegion';
  static const brandStory = 'brandStory';
  static const address = 'address';
  static const addressEdit = 'addressEdit';
  static const points = 'points';
  static const footprint = 'footprint';
  static const feedback = 'feedback';
  static const service = 'service';
  static const afterSale = 'afterSale';
  static const about = 'about';
}

GoRouter createRouter(AppState appState) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: appState,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/category',
            name: AppRoutes.category,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CategoryScreen(),
            ),
          ),
          GoRoute(
            path: '/culture',
            name: AppRoutes.culture,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TeaCultureScreen(),
            ),
          ),
          GoRoute(
            path: '/cart',
            name: AppRoutes.cart,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CartScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            name: AppRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/products/:id',
        name: AppRoutes.product,
        builder: (context, state) {
          final extra = state.extra;
          final product = extra is TeaProduct
              ? extra
              : SampleData.productById(state.pathParameters['id'] ?? '');
          if (product == null) return const CategoryScreen();
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: '/search',
        name: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/favorites',
        name: AppRoutes.favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/coupons',
        name: AppRoutes.coupons,
        builder: (context, state) => const CouponScreen(),
      ),
      GoRoute(
        path: '/orders',
        name: AppRoutes.orders,
        builder: (context, state) {
          final statusName = state.uri.queryParameters['status'];
          OrderStatus? status;
          for (final item in OrderStatus.values) {
            if (item.name == statusName) {
              status = item;
              break;
            }
          }
          return OrderListScreen(initialStatus: status);
        },
      ),
      GoRoute(
        path: '/order-confirm',
        name: AppRoutes.orderConfirm,
        builder: (context, state) {
          final payload = state.extra;
          if (payload is OrderConfirmPayload) {
            return OrderConfirmScreen(lines: payload.lines, total: payload.total);
          }
          return OrderConfirmScreen(
            lines: appState.selectedCartItems,
            total: appState.cartTotal,
          );
        },
      ),
      GoRoute(
        path: '/payment/:total',
        name: AppRoutes.payment,
        builder: (context, state) {
          final total = int.tryParse(state.pathParameters['total'] ?? '') ?? 0;
          return PaymentScreen(total: total);
        },
      ),
      GoRoute(
        path: '/payment-success/:total',
        name: AppRoutes.paymentSuccess,
        builder: (context, state) {
          final total = int.tryParse(state.pathParameters['total'] ?? '') ?? 0;
          return PaymentSuccessScreen(total: total);
        },
      ),
      GoRoute(
        path: '/logistics',
        name: AppRoutes.logistics,
        builder: (context, state) => const LogisticsScreen(),
      ),
      GoRoute(
        path: '/reviews/:productName',
        name: AppRoutes.reviews,
        builder: (context, state) {
          return ReviewsScreen(productName: state.pathParameters['productName'] ?? '');
        },
      ),
      GoRoute(
        path: '/notifications',
        name: AppRoutes.notifications,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/brewing',
        name: AppRoutes.brewing,
        builder: (context, state) => const BrewingGuideScreen(),
      ),
      GoRoute(
        path: '/ai-recommend',
        name: AppRoutes.aiRecommend,
        builder: (context, state) => const AiRecommendScreen(),
      ),
      GoRoute(
        path: '/gift-customize',
        name: AppRoutes.giftCustomize,
        builder: (context, state) => const GiftCustomizeScreen(),
      ),
      GoRoute(
        path: '/solar-terms',
        name: AppRoutes.solarTerms,
        builder: (context, state) {
          final index = int.tryParse(state.uri.queryParameters['index'] ?? '') ?? 0;
          return SolarTermScreen(initialIndex: index);
        },
      ),
      GoRoute(
        path: '/tea-space',
        name: AppRoutes.teaSpace,
        builder: (context, state) => const TeaSpaceScreen(),
      ),
      GoRoute(
        path: '/tea-region',
        name: AppRoutes.teaRegion,
        builder: (context, state) => const TeaRegionScreen(),
      ),
      GoRoute(
        path: '/brand-story',
        name: AppRoutes.brandStory,
        builder: (context, state) => const BrandStoryScreen(),
      ),
      GoRoute(
        path: '/address',
        name: AppRoutes.address,
        builder: (context, state) => const AddressScreen(),
      ),
      GoRoute(
        path: '/address/edit',
        name: AppRoutes.addressEdit,
        builder: (context, state) => AddressEditScreen(
          address: state.extra is AddressEntry ? state.extra! as AddressEntry : null,
        ),
      ),
      GoRoute(
        path: '/points',
        name: AppRoutes.points,
        builder: (context, state) => const PointsScreen(),
      ),
      GoRoute(
        path: '/footprint',
        name: AppRoutes.footprint,
        builder: (context, state) => const FootprintScreen(),
      ),
      GoRoute(
        path: '/feedback',
        name: AppRoutes.feedback,
        builder: (context, state) => const FeedbackScreen(),
      ),
      GoRoute(
        path: '/service',
        name: AppRoutes.service,
        builder: (context, state) => const CustomerServiceScreen(),
      ),
      GoRoute(
        path: '/after-sale',
        name: AppRoutes.afterSale,
        builder: (context, state) => const AfterSaleScreen(),
      ),
      GoRoute(
        path: '/about',
        name: AppRoutes.about,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
}

class OrderConfirmPayload {
  const OrderConfirmPayload({required this.lines, required this.total});

  final List<CartItem> lines;
  final int total;
}
