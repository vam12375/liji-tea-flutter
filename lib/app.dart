import 'package:flutter/material.dart';

import 'data/sample_data.dart';
import 'screens/cart_screen.dart';
import 'screens/category_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/tea_space_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_typography.dart';

/// Root navigation shell with the 5-tab bottom bar from the design system:
/// 首页 / 分类 / 茶文化 / 购物车 / 我的.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _tabs = <_TabItem>[
    _TabItem('首页', Icons.home_outlined, Icons.home),
    _TabItem('分类', Icons.grid_view_outlined, Icons.grid_view),
    _TabItem('茶席', Icons.rice_bowl_outlined, Icons.rice_bowl),
    _TabItem('购物车', Icons.shopping_cart_outlined, Icons.shopping_cart),
    _TabItem('我的', Icons.person_outline, Icons.person),
  ];

  late final List<Widget> _pages = [
    HomeScreen(onSelectTab: (i) => setState(() => _index = i)),
    const CategoryScreen(),
    const TeaSpaceScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.riceWhite,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                for (var i = 0; i < _tabs.length; i++)
                  Expanded(
                    child: _NavButton(
                      tab: _tabs[i],
                      selected: _index == i,
                      badge: i == 3 ? SampleData.cart.length : 0,
                      onTap: () => setState(() => _index = i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.tab,
    required this.selected,
    required this.onTap,
    this.badge = 0,
  });

  final _TabItem tab;
  final bool selected;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.inkGreen : AppColors.textTertiary;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IconWithBadge(
            icon: selected ? tab.activeIcon : tab.icon,
            color: color,
            badge: badge,
          ),
          const SizedBox(height: 4),
          Text(
            tab.label,
            style: AppTypography.sans(
              size: 11,
              weight: selected ? FontWeight.w600 : FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconWithBadge extends StatelessWidget {
  const _IconWithBadge({required this.icon, required this.color, required this.badge});

  final IconData icon;
  final Color color;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: color, size: 24),
        if (badge > 0)
          Positioned(
            right: -7,
            top: -5,
            child: Container(
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              decoration: const BoxDecoration(
                color: AppColors.inkGreen,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$badge',
                style: AppTypography.sans(
                    size: 9, weight: FontWeight.w700, color: AppColors.riceWhite),
              ),
            ),
          ),
      ],
    );
  }
}

class _TabItem {
  const _TabItem(this.label, this.icon, this.activeIcon);

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
