import 'package:sss/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../constants/sizes.dart';

class MyTextFormFieldTheme {
  MyTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    prefixIconColor: MyColors.iconSecondaryLight,
    floatingLabelStyle: const TextStyle(color: MyColors.primary),
    fillColor: MyColors.lightContainer,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: MyColors.lightContainer),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: MyColors.lightContainer),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: MyColors.lightContainer),
    ),
    hintStyle: const TextStyle(color: MyColors.placeholderInactive),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: MyColors.lightContainer),
    ),
  );

  static InputDecoration lightInputDecoration({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      floatingLabelStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MyColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MyColors.primary),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 1, color: MyColors.primary),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusMd),
        borderSide: const BorderSide(width: 2, color: MyColors.primary),
      ),
    );
  }
}
