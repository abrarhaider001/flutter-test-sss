import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';

/// Rounded container: Row [Iconsax icon | vertical divider | text field without border].
/// No light grey fill – white background, subtle border. Uses controller so keyboard does not dismiss on input.
class LabeledIconTextField extends StatefulWidget {
  const LabeledIconTextField({
    super.key,
    required this.hint,
    required this.iconsaxIcon,
    required this.value,
    required this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  });

  final String hint;
  final IconData iconsaxIcon;
  final String value;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<LabeledIconTextField> createState() => _LabeledIconTextFieldState();
}

class _LabeledIconTextFieldState extends State<LabeledIconTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(LabeledIconTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync from parent when value changes externally (e.g. form reset)
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _controller.text.trim().isNotEmpty;
    final iconColor = hasValue ? MyColors.primary : MyColors.iconSecondaryLight;
    const radius = 999.0; // pill shape

    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: MyColors.borderLight.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.readOnly ? widget.onTap : null,
          borderRadius: BorderRadius.circular(radius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MySizes.md,
              vertical: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(widget.iconsaxIcon, color: iconColor, size: 20),
                const SizedBox(width: MySizes.sm),
                Container(
                  width: 1,
                  height: 40,
                  color: MyColors.borderLight.withValues(alpha: 0.5),
                ),
                const SizedBox(width: MySizes.sm),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    readOnly: widget.readOnly,
                    onTap: widget.onTap,
                    onChanged: widget.readOnly ? (_) {} : widget.onChanged,
                    obscureText: widget.obscureText,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: const TextStyle(
                        color: MyColors.placeholderInactive,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      isDense: true,
                      suffixIcon: widget.readOnly ? null : widget.suffixIcon,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
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
