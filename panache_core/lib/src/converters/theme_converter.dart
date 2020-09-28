import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_core/src/converters/app_bar_converter.dart';
import 'package:panache_core/src/converters/bottom_app_bar_converter.dart';
import 'package:panache_core/src/converters/bottom_navigation_bar_converter.dart';
import 'package:panache_core/src/converters/bottom_sheet_converter.dart';
import 'package:panache_core/src/converters/button_bar_converter.dart';
import 'package:panache_core/src/converters/card_converter.dart';
import 'package:panache_core/src/converters/chip_theme_converter.dart';
import 'package:panache_core/src/converters/dialog_converter.dart';
import 'package:panache_core/src/converters/divider_converter.dart';
import 'package:panache_core/src/converters/floating_action_button_converter.dart';
import 'package:panache_core/src/converters/material_banner_converter.dart';
import 'package:panache_core/src/converters/navigation_rail_converter.dart';
import 'package:panache_core/src/converters/popup_menu_converter.dart';
import 'package:panache_core/src/converters/slider_converter.dart';
import 'package:panache_core/src/converters/snack_bar_converter.dart';
import 'package:panache_core/src/converters/tab_bar_converter.dart';
import 'package:panache_core/src/converters/time_picker_converter.dart';
import 'package:panache_core/src/converters/toggles_buttons_converter.dart';
import 'package:panache_core/src/converters/tooltip_converter.dart';

import '../utils/color_utils.dart';
import 'button_theme_converters.dart';
import 'converter_utils.dart';
import 'icon_theme_converter.dart';
import 'input_theme_converter.dart';
import 'text_theme_converters.dart';

ThemeData defaultLightTheme =
    ThemeData.localize(ThemeData.light(), Typography.englishLike2018);

ThemeData defaultDarkTheme =
    ThemeData.localize(ThemeData.dark(), Typography.englishLike2018);

String themeToCode(ThemeData theme) {
  String themeCode;
  themeCode = '''
  import 'package:flutter/material.dart';
  final ThemeData myTheme = ThemeData(
    primarySwatch: ${materialSwatchCodeFor(color: theme.primaryColor)},
    brightness: ${theme.brightness},
    primaryColor: ${colorToCode(theme.primaryColor)},
    primaryColorBrightness: ${theme.primaryColorBrightness},
    primaryColorLight: ${colorToCode(theme.primaryColorLight)},
    primaryColorDark: ${colorToCode(theme.primaryColorDark)},
    accentColor: ${colorToCode(theme.accentColor)},
    accentColorBrightness: ${theme.accentColorBrightness},
    canvasColor: ${colorToCode(theme.canvasColor)},
    scaffoldBackgroundColor: ${colorToCode(theme.scaffoldBackgroundColor)},
    bottomAppBarColor: ${colorToCode(theme.bottomAppBarColor)},
    cardColor: ${colorToCode(theme.cardColor)},
    dividerColor: ${colorToCode(theme.dividerColor)},
    highlightColor: ${colorToCode(theme.highlightColor)},
    splashColor: ${colorToCode(theme.splashColor)},
    selectedRowColor: ${colorToCode(theme.selectedRowColor)},
    unselectedWidgetColor: ${colorToCode(theme.unselectedWidgetColor)},
    disabledColor: ${colorToCode(theme.disabledColor)},
    buttonColor: ${colorToCode(theme.buttonColor)},
    toggleableActiveColor: ${colorToCode(theme.toggleableActiveColor)},
    secondaryHeaderColor: ${colorToCode(theme.secondaryHeaderColor)},
    textSelectionColor: ${colorToCode(theme.textSelectionColor)},
    cursorColor: ${colorToCode(theme.cursorColor)},
    textSelectionHandleColor: ${colorToCode(theme.textSelectionHandleColor)},
    backgroundColor: ${colorToCode(theme.backgroundColor)},
    dialogBackgroundColor: ${colorToCode(theme.dialogBackgroundColor)},
    indicatorColor: ${colorToCode(theme.indicatorColor)},
    hintColor: ${colorToCode(theme.hintColor)},
    errorColor: ${colorToCode(theme.errorColor)},
    colorScheme: ${colorSchemeToCode(theme.colorScheme)},
    buttonTheme: ${buttonThemeToCode(theme.buttonTheme)},
    textTheme: ${textThemeToCode(theme.textTheme)},
    primaryTextTheme: ${textThemeToCode(theme.primaryTextTheme)},
    accentTextTheme: ${textThemeToCode(theme.accentTextTheme)},
    inputDecorationTheme: ${inputDecorationThemeToCode(
    theme.inputDecorationTheme,
    theme.hintColor,
    theme.textTheme.bodyText2,
    theme.brightness,
  )},
    iconTheme: ${iconThemeToCode(theme.iconTheme)},
    primaryIconTheme: ${iconThemeToCode(theme.primaryIconTheme)},
    accentIconTheme: ${iconThemeToCode(theme.accentIconTheme)},
    sliderTheme: ${sliderThemeToCode(
    theme.sliderTheme,
    theme.accentTextTheme.bodyText1,
  )},
    tabBarTheme: ${tabBarThemeToCode(
    theme.tabBarTheme,
    defaultLabelColor: theme.primaryTextTheme.bodyText1.color,
  )},
    chipTheme: ${chipThemeToCode(
    theme.chipTheme,
    defaultLabelStyle: theme.textTheme.bodyText1,
  )},
    dialogTheme: ${dialogThemeToCode(theme.dialogTheme)},

  ''';
  if (appBarThemeIsNull(theme.appBarTheme) == false) {
    themeCode += '''
    appBarTheme: ${appBarThemeToCode(theme.appBarTheme)},
    ''';
  }

  if (bottomAppBarThemeIsNull(theme.bottomAppBarTheme) == false) {
    themeCode += '''
    bottomAppBarTheme: ${bottomAppBarThemeToCode(theme.bottomAppBarTheme)},
    ''';
  }

  if (bottomNavigationBarThemeIsNull(theme.bottomNavigationBarTheme) == false) {
    themeCode += '''
    bottomNavigationBarTheme: ${bottomNavigationBarThemeToCode(theme.bottomNavigationBarTheme)},
    ''';
  }

  if (toggleButtonsThemeDataIsNull(theme.toggleButtonsTheme) == false) {
    themeCode += '''
    toggleButtonsTheme: ${toggleButtonsThemeToCode(theme.toggleButtonsTheme)},
    ''';
  }

  if (cardThemeDataIsNull(theme.cardTheme) == false) {
    themeCode += '''
    cardTheme: ${cardThemeToCode(theme.cardTheme)},
    ''';
  }

  if (tooltipThemeDataIsNull(theme.tooltipTheme) == false) {
    themeCode += '''
    tooltipTheme: ${tooltipThemeToCode(theme.tooltipTheme)},
    ''';
  }

  if (snackBarThemeDataIsNull(theme.snackBarTheme) == false) {
    themeCode += '''
    snackBarTheme: ${snackBarThemeToCode(theme.snackBarTheme)},
    ''';
  }

  if (bottomSheetThemeDataIsNull(theme.bottomSheetTheme) == false) {
    themeCode += '''
    bottomSheetTheme: ${bottomSheetThemeToCode(theme.bottomSheetTheme)},
    ''';
  }
  if (popupMenuThemeDataIsNull(theme.popupMenuTheme) == false) {
    themeCode += '''
    popupMenuTheme: ${popupMenuThemeToCode(theme.popupMenuTheme)},
    ''';
  }

  if (timePickerThemeDataIsNull(theme.timePickerTheme) == false) {
    themeCode += '''
    timePickerTheme: ${timePickerThemeToCode(theme.timePickerTheme, theme.hintColor, theme.textTheme.bodyText2, theme.brightness)},
    ''';
  }

  if (buttonBarThemeDataIsNull(theme.buttonBarTheme) == false) {
    themeCode += '''
    buttonBarTheme: ${buttonBarThemeToCode(theme.buttonBarTheme)},
    ''';
  }

  if (floatingActionButtonThemeDataIsNull(theme.floatingActionButtonTheme) ==
      false) {
    themeCode += '''
    floatingActionButtonTheme: ${floatingActionButtonThemeToCode(theme.floatingActionButtonTheme)},
    ''';
  }

  if (materialBannerThemeDataIsNull(theme.bannerTheme) == false) {
    themeCode += '''
    bannerTheme: ${materialBannerThemeToCode(theme.bannerTheme)},
    ''';
  }
  if (dividerThemeDataIsNull(theme.dividerTheme) == false) {
    themeCode += '''
    dividerTheme: ${dividerThemeToCode(theme.dividerTheme)},
    ''';
  }

  if (navigationRailThemeDataIsNull(theme.navigationRailTheme) == false) {
    themeCode += '''
    navigationRailTheme: ${navigationRailThemeToCode(theme.navigationRailTheme)},
    ''';
  }

//Fin de fichier
  themeCode += '''
      );
    ''';
  return themeCode;
}
/*
    TODO
    colorScheme: ${theme.colorScheme},
    splashFactory: ${theme.splashFactory},
    materialTapTargetSize: ${theme.materialTapTargetSize},
    pageTransitionsTheme: ${theme.pageTransitionsTheme},
    platform: ${theme.platform},
 */

Map<String, dynamic> themeToMap(ThemeData theme) {
  Map<String, dynamic> themeToMap;
  themeToMap = <String, dynamic>{
    "primarySwatch": theme.primaryColor?.value,
    'brightness': brightnessIndex(theme.brightness),
    'primaryColor': theme.primaryColor?.value,
    'primaryColorBrightness': brightnessIndex(theme.primaryColorBrightness),
    'primaryColorLight': theme.primaryColorLight.value,
    'primaryColorDark': theme.primaryColorDark.value,
    'accentColor': theme.accentColor?.value,
    'accentColorBrightness': brightnessIndex(theme.accentColorBrightness),
    'canvasColor': theme.canvasColor?.value,
    'scaffoldBackgroundColor': theme.scaffoldBackgroundColor?.value,
    'bottomAppBarColor': theme.bottomAppBarColor?.value,
    'cardColor': theme.cardColor?.value,
    'dividerColor': theme.dividerColor?.value,
    'highlightColor': theme.highlightColor?.value,
    'splashColor': theme.splashColor?.value,
    'selectedRowColor': theme.selectedRowColor?.value,
    'unselectedWidgetColor': theme.unselectedWidgetColor?.value,
    'disabledColor': theme.disabledColor?.value,
    'buttonColor': theme.buttonColor?.value,
    'toggleableActiveColor': theme.toggleableActiveColor?.value,
    'secondaryHeaderColor': theme.secondaryHeaderColor?.value,
    'textSelectionColor': theme.textSelectionColor?.value,
    'cursorColor': theme.cursorColor?.value,
    'textSelectionHandleColor': theme.textSelectionHandleColor?.value,
    'backgroundColor': theme.backgroundColor?.value,
    'dialogBackgroundColor': theme.dialogBackgroundColor?.value,
    'indicatorColor': theme.indicatorColor?.value,
    'hintColor': theme.hintColor?.value,
    'errorColor': theme.errorColor?.value,
    'colorScheme': colorSchemeToMap(theme.colorScheme),
    'buttonTheme': buttonThemeToMap(theme.buttonTheme),
    'textTheme': textThemeToMap(theme.textTheme),
    'primaryTextTheme': textThemeToMap(theme.primaryTextTheme),
    'accentTextTheme': textThemeToMap(theme.accentTextTheme),
    'inputDecorationTheme': inputDecorationThemeToMap(
        theme.inputDecorationTheme,
        theme.hintColor,
        theme.textTheme.bodyText2,
        theme.brightness),
    'iconTheme': iconThemeToMap(theme.iconTheme),
    'primaryIconTheme': iconThemeToMap(theme.primaryIconTheme),
    'accentIconTheme': iconThemeToMap(theme.accentIconTheme),
    'sliderTheme':
        sliderThemeToMap(theme.sliderTheme, theme.accentTextTheme.bodyText1),
    'tabBarTheme': tabBarThemeToMap(theme.tabBarTheme,
        defaultLabelColor: theme.primaryTextTheme.bodyText1.color),
    'chipTheme': chipThemeToMap(
      theme.chipTheme,
      defaultLabelStyle: theme.textTheme.bodyText1,
    ),
    'dialogTheme': dialogThemeToMap(theme.dialogTheme),
  };
  //AppBarTheme not initialized with default values
  //https://api.flutter.dev/flutter/material/ThemeData-class.html
  //https://api.flutter.dev/flutter/material/AppBarTheme-class.html
  //https://api.flutter.dev/flutter/material/AppBar/textTheme.html
  if (appBarThemeIsNull(theme.appBarTheme) == false) {
    themeToMap.update(
        'appBarTheme', (value) => appBarThemeToMap(theme.appBarTheme),
        ifAbsent: () => appBarThemeToMap(theme.appBarTheme));
  }
  //https://api.flutter.dev/flutter/material/BottomAppBarTheme-class.html
  if (bottomAppBarThemeIsNull(theme.bottomAppBarTheme) == false) {
    themeToMap.update('bottomAppBarTheme',
        (dynamic value) => bottomAppBarThemeToMap(theme.bottomAppBarTheme),
        ifAbsent: () => bottomAppBarThemeToMap(theme.bottomAppBarTheme));
  }

  if (bottomNavigationBarThemeIsNull(theme.bottomNavigationBarTheme) == false) {
    themeToMap.update(
        'bottomNavigationBarTheme',
        (dynamic value) =>
            bottomNavigationBarThemeToMap(theme.bottomNavigationBarTheme),
        ifAbsent: () =>
            bottomNavigationBarThemeToMap(theme.bottomNavigationBarTheme));
  }

  if (toggleButtonsThemeDataIsNull(theme.toggleButtonsTheme) == false) {
    themeToMap.update('toggleButtonsTheme',
        (dynamic value) => toggleButtonsThemeToMap(theme.toggleButtonsTheme),
        ifAbsent: () => toggleButtonsThemeToMap(theme.toggleButtonsTheme));
  }

  if (cardThemeDataIsNull(theme.cardTheme) == false) {
    themeToMap.update(
        'cardTheme', (dynamic value) => cardThemeToMap(theme.cardTheme),
        ifAbsent: () => cardThemeToMap(theme.cardTheme));
  }

  if (tooltipThemeDataIsNull(theme.tooltipTheme) == false) {
    themeToMap.update('tooltipTheme',
        (dynamic value) => tooltipThemeToMap(theme.tooltipTheme),
        ifAbsent: () => tooltipThemeToMap(theme.tooltipTheme));
  }

  if (snackBarThemeDataIsNull(theme.snackBarTheme) == false) {
    themeToMap.update('snackBarTheme',
        (dynamic value) => snackBarThemeToMap(theme.snackBarTheme),
        ifAbsent: () => snackBarThemeToMap(theme.snackBarTheme));
  }

  if (bottomSheetThemeDataIsNull(theme.bottomSheetTheme) == false) {
    themeToMap.update('bottomSheetTheme',
        (dynamic value) => bottomSheetThemeToMap(theme.bottomSheetTheme),
        ifAbsent: () => bottomSheetThemeToMap(theme.bottomSheetTheme));
  }

  if (popupMenuThemeDataIsNull(theme.popupMenuTheme) == false) {
    themeToMap.update('popupMenuTheme',
        (dynamic value) => popupMenuThemeToMap(theme.popupMenuTheme),
        ifAbsent: () => popupMenuThemeToMap(theme.popupMenuTheme));
  }

  if (timePickerThemeDataIsNull(theme.timePickerTheme) == false) {
    themeToMap.update(
        'timePickerTheme',
        (dynamic value) => timePickerThemeToMap(theme.timePickerTheme,
            theme.hintColor, theme.textTheme.bodyText2, theme.brightness),
        ifAbsent: () => timePickerThemeToMap(theme.timePickerTheme,
            theme.hintColor, theme.textTheme.bodyText2, theme.brightness));
  }

  if (buttonBarThemeDataIsNull(theme.buttonBarTheme) == false) {
    themeToMap.update('buttonBarTheme',
        (dynamic value) => buttonBarThemeToMap(theme.buttonBarTheme),
        ifAbsent: () => buttonBarThemeToMap(theme.buttonBarTheme));
  }

  if (floatingActionButtonThemeDataIsNull(theme.floatingActionButtonTheme) ==
      false) {
    themeToMap.update(
        'floatingActionButtonTheme',
        (dynamic value) =>
            floatingActionButtonThemeToMap(theme.floatingActionButtonTheme),
        ifAbsent: () =>
            floatingActionButtonThemeToMap(theme.floatingActionButtonTheme));
  }

  if (materialBannerThemeDataIsNull(theme.bannerTheme) == false) {
    themeToMap.update('bannerTheme',
        (dynamic value) => materialBannerThemeToMap(theme.bannerTheme),
        ifAbsent: () => materialBannerThemeToMap(theme.bannerTheme));
  }

  if (dividerThemeDataIsNull(theme.dividerTheme) == false) {
    themeToMap.update('dividerTheme',
        (dynamic value) => dividerThemeToMap(theme.dividerTheme),
        ifAbsent: () => dividerThemeToMap(theme.dividerTheme));
  }

  if (navigationRailThemeDataIsNull(theme.navigationRailTheme) == false) {
    themeToMap.update('navigationRailTheme',
        (dynamic value) => navigationRailThemeToMap(theme.navigationRailTheme),
        ifAbsent: () => navigationRailThemeToMap(theme.navigationRailTheme));
  }

  return themeToMap;
}

ThemeData themeFromJson(String jsonTheme) {
  ThemeData defaultTheme = ThemeData.light();
  Map<String, dynamic> themeMap = json.decode(jsonTheme);
  MaterialColor defaultColor = Colors.cyan;

  ThemeData theme;
  theme = ThemeData(
    primarySwatch: swatchFor(
        color: Color(themeMap['primarySwatch'] ?? defaultColor?.value)),
    brightness:
        Brightness.values[max(Brightness.light.index, themeMap['brightness'])],
    primaryColor: Color(themeMap['primaryColor'] ?? defaultColor),
    primaryColorBrightness: Brightness.values[max(
        defaultTheme.primaryColorBrightness.index,
        themeMap['primaryColorBrightness'])],
    primaryColorLight: Color(
        themeMap['primaryColorLight'] ?? defaultTheme.primaryColorLight.value),
    primaryColorDark: Color(
        themeMap['primaryColorDark'] ?? defaultTheme.primaryColorDark.value),
    accentColor:
        Color(themeMap['accentColor'] ?? defaultTheme.accentColor?.value),
    accentColorBrightness: Brightness.values[max(
        defaultTheme.accentColorBrightness.index,
        themeMap['accentColorBrightness'])],
    canvasColor:
        Color(themeMap['canvasColor'] ?? defaultTheme.canvasColor?.value),
    scaffoldBackgroundColor: Color(themeMap['scaffoldBackgroundColor'] ??
        defaultTheme.scaffoldBackgroundColor?.value),
    bottomAppBarColor:
        Color(themeMap['bottomAppBarColor'] ?? defaultTheme.bottomAppBarColor),
    cardColor: Color(themeMap['cardColor'] ?? defaultTheme.cardColor),
    dividerColor: Color(themeMap['dividerColor'] ?? defaultTheme.dividerColor),
    highlightColor:
        Color(themeMap['highlightColor'] ?? defaultTheme.highlightColor),
    splashColor: Color(themeMap['splashColor'] ?? defaultTheme.splashColor),
    selectedRowColor:
        Color(themeMap['selectedRowColor'] ?? defaultTheme.selectedRowColor),
    unselectedWidgetColor: Color(themeMap['unselectedWidgetColor'] ??
        defaultTheme.unselectedWidgetColor),
    disabledColor:
        Color(themeMap['disabledColor'] ?? defaultTheme.disabledColor),
    buttonColor: Color(themeMap['buttonColor'] ?? defaultTheme.buttonColor),
    toggleableActiveColor: Color(themeMap['toggleableActiveColor'] ??
        defaultTheme.toggleableActiveColor),
    secondaryHeaderColor: Color(
        themeMap['secondaryHeaderColor'] ?? defaultTheme.secondaryHeaderColor),
    textSelectionColor: Color(
        themeMap['textSelectionColor'] ?? defaultTheme.textSelectionColor),
    cursorColor: Color(themeMap['cursorColor'] ?? defaultTheme.cursorColor),
    textSelectionHandleColor: Color(themeMap['textSelectionHandleColor'] ??
        defaultTheme.textSelectionHandleColor),
    backgroundColor:
        Color(themeMap['backgroundColor'] ?? defaultTheme.backgroundColor),
    dialogBackgroundColor: Color(themeMap['dialogBackgroundColor'] ??
        defaultTheme.dialogBackgroundColor),
    indicatorColor:
        Color(themeMap['indicatorColor'] ?? defaultTheme.indicatorColor),
    hintColor: Color(themeMap['hintColor'] ?? defaultTheme.hintColor),
    errorColor: Color(themeMap['errorColor'] ?? defaultTheme.errorColor),
    buttonTheme: buttonThemeFromMap(themeMap['buttonTheme']) ??
        ThemeData.light().buttonTheme,
    textTheme:
        textThemeFromMap(themeMap['textTheme']) ?? defaultTheme.textTheme,
    primaryTextTheme: textThemeFromMap(themeMap['primaryTextTheme']) ??
        defaultTheme.primaryTextTheme,
    accentTextTheme: textThemeFromMap(themeMap['accentTextTheme']) ??
        defaultTheme.accentTextTheme,
    iconTheme:
        iconThemeFromMap(themeMap['iconTheme']) ?? defaultTheme.iconTheme,
    primaryIconTheme: iconThemeFromMap(themeMap['primaryIconTheme']) ??
        defaultTheme.primaryIconTheme,
    accentIconTheme: iconThemeFromMap(themeMap['accentIconTheme']) ??
        defaultTheme.accentTextTheme,
    sliderTheme:
        sliderThemeFromMap(themeMap['sliderTheme']) ?? defaultTheme.sliderTheme,
    tabBarTheme:
        tabBarThemeFromMap(themeMap['tabBarTheme']) ?? defaultTheme.tabBarTheme,
    chipTheme: chipThemeFromMap(themeMap['chipTheme'],
            brightness: Brightness
                .values[max(Brightness.light.index, themeMap['brightness'])],
            secondaryColor: defaultTheme.primaryColor,
            labelStyle: defaultTheme.chipTheme.labelStyle) ??
        defaultTheme.chipTheme,
    inputDecorationTheme:
        inputDecorationThemeFromMap(themeMap['inputDecorationTheme']) ??
            defaultTheme.inputDecorationTheme,
    dialogTheme:
        dialogThemeFromMap(themeMap['dialogTheme']) ?? defaultTheme.textTheme,
    appBarTheme:
        appBarThemeFromMap(themeMap['appBarTheme']) ?? defaultTheme.appBarTheme,
    platform: defaultTheme.platform,
    colorScheme: colorSchemeFromMap(themeMap['colorScheme']) ??
        defaultLightTheme.colorScheme,
    bottomAppBarTheme:
        bottomAppBarThemeFromMap(themeMap['bottomAppBarTheme']) ??
            defaultLightTheme.bottomAppBarTheme,
    bottomNavigationBarTheme:
        bottomNavigationBarThemeFromMap(themeMap['bottomNavigationBarTheme']) ??
            defaultLightTheme.bottomNavigationBarTheme,
    toggleButtonsTheme:
        toggleButtonsThemeFromMap(themeMap['toggleButtonsTheme']) ??
            defaultLightTheme.toggleButtonsTheme,
    cardTheme:
        cardThemeFromMap(themeMap['cardTheme']) ?? defaultLightTheme.cardTheme,
    tooltipTheme: tooltipThemeFromMap(themeMap['tooltipTheme']) ??
        defaultLightTheme.tooltipTheme,
    snackBarTheme: snackBarhemeFromMap(themeMap['snackBarTheme']) ??
        defaultLightTheme.snackBarTheme,
    bottomSheetTheme: bottomSheetThemeFromMap(themeMap['bottomSheetTheme']) ??
        defaultLightTheme.bottomSheetTheme,
    popupMenuTheme: popupMenuThemeFromMap(themeMap['popupMenuTheme']) ??
        defaultLightTheme.popupMenuTheme,
    timePickerTheme: timePickerThemeFromMap(themeMap['timePickerTheme']) ??
        defaultLightTheme.timePickerTheme,
    buttonBarTheme: buttonBarThemeFromMap(themeMap['buttonBarTheme']) ??
        defaultLightTheme.buttonBarTheme,
    floatingActionButtonTheme: floatingActionButtonThemeFromMap(
            themeMap['floatingActionButtonTheme']) ??
        defaultLightTheme.floatingActionButtonTheme,
    bannerTheme: materialBannerThemeFromMap(themeMap['bannerTheme']) ??
        defaultLightTheme.bannerTheme,
    dividerTheme: dividerThemeFromMap(themeMap['dividerTheme']) ??
        defaultLightTheme.dividerTheme,
    navigationRailTheme:
        navigationRailThemeFromMap(themeMap['navigationRailTheme']) ??
            defaultLightTheme.navigationRailTheme,

    /*
    fontFamily:
    pageTransitionsTheme:
    materialTapTargetSize:
    splashFactory:
    typography:
    */
  );

  return theme;
}

int brightnessIndex(Brightness value) =>
    max(0, Brightness.values.indexOf(value));

String instanceToCode(dynamic instance) =>
    '$instance()'.replaceAll("Instance of '", '').replaceAll("'", "");
