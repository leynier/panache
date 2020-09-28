import 'dart:math';

import 'package:flutter/material.dart';

import 'converter_utils.dart';

String buttonBarThemeToCode(
  ButtonBarThemeData theme,
) {
  return '''
  ButtonBarThemeData(
     buttonTextTheme: ${theme.buttonTextTheme},
    buttonAlignedDropdown: ${theme.buttonAlignedDropdown},
    alignment: ${theme.alignment},
    buttonHeight: ${theme.buttonHeight},
    buttonMinWidth: ${theme.buttonMinWidth},
    buttonPadding: ${theme.buttonPadding},
    layoutBehavior: ${theme.layoutBehavior},
    mainAxisSize: ${theme.mainAxisSize},
    overflowDirection: ${theme.overflowDirection},
    )''';
}

Map<String, dynamic> buttonBarThemeToMap(
  ButtonBarThemeData theme,
) {
  return <String, dynamic>{
    'buttonTextTheme': ButtonTextTheme.values.indexOf(theme.buttonTextTheme),
    'buttonAlignedDropdown': theme.buttonAlignedDropdown,
    'alignment': MainAxisAlignment.values.indexOf(theme.alignment),
    'buttonHeight': theme.buttonHeight,
    'buttonMinWidth': theme.buttonMinWidth,
    'buttonPadding': theme.buttonPadding,
    'layoutBehavior':
        ButtonBarLayoutBehavior.values.indexOf(theme.layoutBehavior),
    'mainAxisSize': MainAxisSize.values.indexOf(theme.mainAxisSize),
    'overflowDirection':
        VerticalDirection.values.indexOf(theme.overflowDirection),
  };
}

ButtonBarThemeData buttonBarThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return ButtonBarThemeData(
    buttonTextTheme: ButtonTextTheme.values[max(0, data['buttonTextTheme'])],
    buttonAlignedDropdown: data['buttonAlignedDropdown'],
    alignment: MainAxisAlignment.values[max(0, data['alignment'])],
    buttonHeight: data['buttonHeight'],
    buttonMinWidth: data['buttonMinWidth'],
    buttonPadding: data['buttonPadding'],
    layoutBehavior:
        ButtonBarLayoutBehavior.values[max(0, data['layoutBehavior'])],
    mainAxisSize: MainAxisSize.values[max(0, data['mainAxisSize'])],
    overflowDirection:
        VerticalDirection.values[max(0, data['overflowDirection'])],
  );
}

/// Tester si l'iconThemeDate est null
bool buttonBarThemeDataIsNull(ButtonBarThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.buttonAlignedDropdown == null &&
      theme.alignment == null &&
      theme.buttonHeight == null &&
      theme.buttonMinWidth == null &&
      theme.buttonPadding == null &&
      theme.buttonTextTheme == null &&
      theme.layoutBehavior == null &&
      theme.mainAxisSize == null &&
      theme.overflowDirection == null;
  return objectIsNull;
}
