import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';

/// Tag shortcut chips; hidden behind search bar, expand with pull-down animation.
class HomeChoiceChips extends StatelessWidget {
  const HomeChoiceChips({
    super.key,
    required this.expanded,
    required this.selectedIndex,
    required this.onChipSelected,
  });

  final bool expanded;
  final int selectedIndex;
  final ValueChanged<int> onChipSelected;

  static const List<String> _labels = ['For You', 'Men', 'Women', 'Jackets'];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      height: expanded ? 48 : 0,
      decoration: const BoxDecoration(),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: MySizes.md, vertical: 8),
        child: Row(
          children: List.generate(_labels.length, (index) {
            final isSelected = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Material(
                color: isSelected ? MyColors.primary : MyColors.lightContainer,
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  onTap: () => onChipSelected(index),
                  borderRadius: BorderRadius.circular(999),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      _labels[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? MyColors.textWhite : MyColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
