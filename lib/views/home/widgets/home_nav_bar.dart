import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sss/core/utils/constants/colors.dart';

/// Bottom navigation: Shop, Cart, Profile (Shop selected by default on home).
/// When [transparent] is true, background is transparent to increase content area.
class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.transparent = false,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool transparent;

  static const List<({String label, IconData icon})> _items = [
    (label: 'Shop', icon: Iconsax.bag_2),
    (label: 'Cart', icon: Iconsax.shopping_cart),
    (label: 'Profile', icon: Iconsax.user),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: transparent ? Colors.transparent : Colors.white,
        boxShadow: transparent
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = currentIndex == index;
              return GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 24,
                      color: isSelected ? MyColors.primary : MyColors.iconSecondaryLight,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? MyColors.primary : MyColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
