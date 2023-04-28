import 'package:flutter/material.dart';

// region Universal

// Button
const buttonPrimaryBackgroundColor = Color(0xff0f62fe);
const buttonPrimaryForegroundColor = Color(0xfff4f4f4);

// endregion Universal

// region Dark

// Background
const darkBackground = Color(0xff262626);
const darkLayerBackground = Color(0xff525252);

// Button
const darkButtonSecondary = Color(0xff6f6f6f);
const darkButtonSecondaryHover = Color(0xff606060);
const darkButtonSecondaryActive = Color(0xff393939);

const darkButtonDisabled = Color(0xff6f6f6f);

// Text
const darkTextPrimary = Color(0xfff4f4f4);
const darkTextSecondary = Color(0xffc6c6c6);
const darkTextPlaceholder = Color(0xff6f6f6f);
const darkTextDisabled = Color(0x40f4f4f4); // 40 -> 25 % opacity

// Icon
const darkIconPrimary = Color(0xfff4f4f4);
const darkIconSecondary = Color(0xffc6c6c6);
const darkIconInteractive = Color(0xffffffff);
const darkIconDisabled = Color(0x40f4f4f4); // 40 -> 25 % opacity

// endregion Dark

// region Light

// Background
const lightBackground = Color(0xfff4f4f4);
const lightLayerBackground = Color(0xffffffff);

// Button
const lightButtonSecondary = Color(0xff393939);
const lightButtonSecondaryHover = Color(0xff4c4c4c);
const lightButtonSecondaryActive = Color(0xff6f6f6f);

const lightButtonDisabled = Color(0xffc6c6c6);

// Text
const lightTextPrimary = Color(0xff161616);
const lightTextSecondary = Color(0xff525252);
const lightTextPlaceholder = Color(0xffa8a8a8);
const lightTextDisabled = Color(0x40161616); // 40 -> 25 % opacity

// Icon
const lightIconPrimary = Color(0xff161616);
const lightIconSecondary = Color(0xff525252);
const lightIconInteractive = Color(0xffffffff);
const lightIconDisabled = Color(0x40161616); // 40 -> 25 % opacity

// endregion Light

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) =>
    isDarkTheme ? _darkTheme(context) : _lightTheme(context);

ThemeData _darkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkBackground,
    disabledColor: darkIconDisabled,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkLayerBackground,
      foregroundColor: darkTextPrimary,
      elevation: 5.0,
      iconTheme: IconThemeData(color: darkIconPrimary),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: darkBackground,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: darkTextPlaceholder,
      ),
    ),
    iconTheme: const IconThemeData(
      color: darkIconPrimary,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: darkIconPrimary,
    ),
    textTheme: Theme.of(context)
        .textTheme
        .copyWith(
          titleSmall:
              Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 11),
        )
        .apply(
          bodyColor: Colors.white,
          displayColor: Colors.grey,
        ),
  );
}

ThemeData _lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    disabledColor: lightIconDisabled,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightLayerBackground,
      foregroundColor: lightTextPrimary,
      elevation: 5.0,
      iconTheme: IconThemeData(color: lightIconPrimary),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: lightBackground,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: lightTextPlaceholder,
      ),
    ),
    iconTheme: const IconThemeData(
      color: lightIconPrimary,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: lightIconPrimary,
    ),
    textTheme: Theme.of(context)
        .textTheme
        .copyWith(
          titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 11,
                color: Colors.red,
              ),
        )
        .apply(
          bodyColor: Colors.black,
          displayColor: Colors.grey,
        ),
  );
}
