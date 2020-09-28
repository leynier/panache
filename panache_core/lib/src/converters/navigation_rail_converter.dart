import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/icon_theme_converter.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String navigationRailThemeToCode(
  NavigationRailThemeData theme,
) {
  return '''
  NavigationRailThemeData(
      backgroundColor: ${colorToCode(theme.backgroundColor)},
      labelType: ${theme.labelType},
      elevation: ${theme.elevation},
      groupAlignment: ${theme.groupAlignment},
      selectedIconTheme: ${iconThemeToCode(theme.selectedIconTheme)},
      unselectedIconTheme: ${iconThemeToCode(theme.unselectedIconTheme)},
      selectedLabelTextStyle: ${textStyleToCode(theme.selectedLabelTextStyle)},
      unselectedLabelTextStyle: ${textStyleToCode(theme.unselectedLabelTextStyle)},
    )''';
}

Map<String, dynamic> navigationRailThemeToMap(
  NavigationRailThemeData theme,
) {
  return <String, dynamic>{
    'backgroundColor': theme.backgroundColor?.value,
    'labelType':
        max(0, NavigationRailLabelType.values.indexOf(theme.labelType)),
    'elevation': theme.elevation,
    'groupAlignment': theme.groupAlignment,
    'selectedIconTheme': iconThemeToMap(theme.selectedIconTheme),
    'unselectedIconTheme': iconThemeToMap(theme.unselectedIconTheme),
    'selectedLabelTextStyle': textStyleToMap(theme.selectedLabelTextStyle),
    'unselectedLabelTextStyle': textStyleToMap(theme.unselectedLabelTextStyle),
  };
}

NavigationRailThemeData navigationRailThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return NavigationRailThemeData(
    backgroundColor: getColorFromMap(data['backgroundColor']),
    elevation: data['elevation'],
    groupAlignment: data['groupAlignment'],
    labelType: NavigationRailLabelType.values[max(0, data['labelType'] ?? 0)],
    selectedIconTheme: iconThemeFromMap(data['selectedIconTheme']),
    unselectedIconTheme: iconThemeFromMap(data['unselectedIconTheme']),
    selectedLabelTextStyle: textStyleFromMap(data['selectedLabelTextStyle']),
    unselectedLabelTextStyle:
        textStyleFromMap(data['unselectedLabelTextStyle']),
  );
}

/// Tester si l'iconThemeDate est null
bool navigationRailThemeDataIsNull(NavigationRailThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.backgroundColor == null &&
      theme.elevation == null &&
      theme.groupAlignment == null &&
      theme.labelType == null &&
      iconThemeDataIsNull(theme.selectedIconTheme) &&
      iconThemeDataIsNull(theme.unselectedIconTheme) &&
      textStyleIsNull(theme.selectedLabelTextStyle) == true &&
      textStyleIsNull(theme.selectedLabelTextStyle) == true;
  return objectIsNull;
}
