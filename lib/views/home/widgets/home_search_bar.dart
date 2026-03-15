import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';

/// Search bar with Iconsax search (prefix) and filter (suffix).
/// When [focusNode] has focus (liquid glass mode), [isSearching] is true for styling.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.onTap,
    this.controller,
    this.focusNode,
    this.isSearching = false,
  });

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: isSearching ? 0 : MySizes.md),
      decoration: BoxDecoration(
        color: isSearching
            ? Colors.white.withValues(alpha: 0.85)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isSearching
              ? MyColors.borderLight.withValues(alpha: 0.4)
              : MyColors.borderLight.withValues(alpha: 0.6),
        ),
        boxShadow: isSearching
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
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
              focusNode: focusNode,
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
          if (!isSearching)
            Container(
              padding: const EdgeInsets.only(right: 14),
              child: const Icon(Iconsax.filter, color: MyColors.iconSecondaryLight, size: 22),
            ),
        ],
      ),
    );
  }
}
