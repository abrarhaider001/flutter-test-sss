import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyAppBarTheme {
  MyAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: MyColors.dark, size: 18.0),
    actionsIconTheme: IconThemeData(color: MyColors.dark, size: 18.0),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: MyColors.white, size: 18.0),
    actionsIconTheme: IconThemeData(color: MyColors.white, size: 18.0),
  );
}
