import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'converter_utils.dart';

String buttonThemeToCode(ButtonThemeData buttonTheme) {
  String buttonColor =
      colorToCode(buttonTheme.getFillColor(enabledRaisedButton));

  String disabledColor =
      colorToCode(buttonTheme.getDisabledFillColor(disabledRaisedButton));

  String highlightColor =
      colorToCode(buttonTheme.getHighlightColor(enabledRaisedButton));

  String splashColor =
      colorToCode(buttonTheme.getSplashColor(enabledRaisedButton));

  String focusColor =
      colorToCode(buttonTheme.getFocusColor(enabledRaisedButton));

  String hoverColor =
      colorToCode(buttonTheme.getHoverColor(enabledRaisedButton));

  return '''
  ButtonThemeData(
      textTheme: ${buttonTheme.textTheme},
      minWidth: ${buttonTheme.minWidth},
      height: ${buttonTheme.height},
      padding: ${paddingToCode(buttonTheme.padding)},
      shape: ${shapeToCode(buttonTheme.shape)} ,
      alignedDropdown: ${buttonTheme.alignedDropdown} ,
      buttonColor: $buttonColor,
      disabledColor: $disabledColor,
      highlightColor: $highlightColor,
      splashColor: $splashColor,
      focusColor: $focusColor,
      hoverColor: $hoverColor,
      colorScheme: ${colorSchemeToCode(buttonTheme.colorScheme)},
      layoutBehavior: ${buttonTheme.layoutBehavior},
    )''';
}

Map<String, dynamic> buttonThemeToMap(ButtonThemeData buttonTheme) {
  //ButtonThemeData
  return <String, dynamic>{
    'type': 'ButtonThemeData',
    'textTheme': max(0, ButtonTextTheme.values.indexOf(buttonTheme.textTheme)),
    'minWidth': buttonTheme.minWidth.toInt(),
    'height': buttonTheme.height.toInt(),
    'padding': paddingToMap(buttonTheme.padding),
    'shape': shapeToMap(buttonTheme.shape),
    'alignedDropdown': buttonTheme.alignedDropdown ? 0 : 1,
    'buttonColor': buttonTheme.getFillColor(enabledRaisedButton).value,
    'disabledColor':
        buttonTheme.getDisabledFillColor(disabledRaisedButton).value,
    'highlightColor': buttonTheme.getHighlightColor(enabledRaisedButton).value,
    'splashColor': buttonTheme.getSplashColor(enabledRaisedButton).value,
    'focusColor': buttonTheme.getFocusColor(enabledRaisedButton).value,
    'hoverColor': buttonTheme.getHoverColor(enabledRaisedButton).value,
    'colorScheme': colorSchemeToMap(buttonTheme.colorScheme),
    'layoutBehavior':
        ButtonBarLayoutBehavior.values.indexOf(buttonTheme.layoutBehavior),
  };
}

ButtonThemeData buttonThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return ButtonThemeData(
    textTheme: ButtonTextTheme.values[max(0, data['textTheme'])],
    minWidth: (data['minWidth'] as int).toDouble(),
    height: (data['height'] as int).toDouble(),
    padding: paddingFromMap(data['padding']),
    shape: shapeFromMap(data['shape']),
    buttonColor: getColorFromMap(data['buttonColor']),
    disabledColor: getColorFromMap(data['disabledColor']),
    highlightColor: getColorFromMap(data['highlightColor']),
    splashColor: getColorFromMap(data['splashColor']),
    focusColor: getColorFromMap(data['focusColor']),
    hoverColor: getColorFromMap(data['hoverColor']),
    colorScheme: colorSchemeFromMap(data['colorScheme']),
    layoutBehavior:
        ButtonBarLayoutBehavior.values[max(0, data['layoutBehavior'])],
  );
}
