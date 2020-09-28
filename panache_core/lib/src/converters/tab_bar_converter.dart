import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/converter_utils.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

String tabBarThemeToCode(TabBarTheme theme,
    {@required Color defaultLabelColor}) {
  Color selectedColor = theme.labelColor ?? defaultLabelColor;
  Color unselectedColor =
      theme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);

  return '''
  TabBarTheme(
      indicatorSize: ${theme.indicatorSize ?? TabBarIndicatorSize.tab},
      labelColor: ${colorToCode(selectedColor)},
      unselectedLabelColor: ${colorToCode(unselectedColor)},
      labelStyle: ${textStyleToCode(theme.labelStyle)},
      unselectedLabelStyle: ${textStyleToCode(theme.unselectedLabelStyle)},
    )''';
}

/// TODO indicator Decoration
Map<String, dynamic> tabBarThemeToMap(TabBarTheme tabBarTheme,
    {@required Color defaultLabelColor}) {
  Color selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  Color unselectedColor =
      tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return {
    'indicatorSize':
        max(0, TabBarIndicatorSize.values.indexOf(tabBarTheme.indicatorSize)),
    'labelColor': selectedColor?.value,
    'unselectedLabelColor': unselectedColor?.value,
    'labelStyle': textStyleToMap(tabBarTheme.labelStyle),
    'unselectedLabelStyle': textStyleToMap(tabBarTheme.unselectedLabelStyle),
  };
}

TabBarTheme tabBarThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return TabBarTheme(
    indicatorSize:
        TabBarIndicatorSize.values[max(0, data['indicatorSize'] ?? 0)],
    labelColor: getColorFromMap(data['labelColor']),
    unselectedLabelColor: getColorFromMap(data['unselectedLabelColor']),
    labelStyle: textStyleFromMap(data['labelStyle']),
    unselectedLabelStyle: textStyleFromMap(data['unselectedLabelStyle']),
  );
}
