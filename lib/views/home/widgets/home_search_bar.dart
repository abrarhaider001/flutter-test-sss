import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';

/// Search bar with Iconsax search (prefix) and filter (suffix).
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.onTap,
    this.controller,
  });

  final VoidCallback? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: MySizes.md),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: MyColors.borderLight.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 14),
            child: const Icon(Iconsax.search_normal_1, color: MyColors.iconSecondaryLight, size: 22),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onTap: onTap,
              readOnly: onTap != null,
              style: const TextStyle(color: MyColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search your product...',
                hintStyle: const TextStyle(
                  color: MyColors.placeholderInactive,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 14),
            child: const Icon(Iconsax.filter, color: MyColors.iconSecondaryLight, size: 22),
          ),
        ],
      ),
    );
  }
}
