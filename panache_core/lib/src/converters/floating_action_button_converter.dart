import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String floatingActionButtonThemeToCode(
  FloatingActionButtonThemeData theme,
) {
  return '''
  FloatingActionButtonThemeData(
    backgroundColor: ${colorToCode(theme.backgroundColor)},
    focusColor: ${colorToCode(theme.focusColor)},
    hoverColor: ${colorToCode(theme.hoverColor)},
    splashColor: ${colorToCode(theme.splashColor)},
    disabledElevation: ${theme.disabledElevation},
    elevation: ${theme.elevation},
    focusElevation: ${theme.focusElevation},
    highlightElevation: ${theme.highlightElevation},
    hoverElevation: ${theme.hoverElevation},
    shape: ${shapeToCode(theme.shape)} ,
    )''';
}

Map<String, dynamic> floatingActionButtonThemeToMap(
  FloatingActionButtonThemeData theme,
) {
  return <String, dynamic>{
    'backgroundColor': theme?.backgroundColor?.value,
    'focusColor': theme?.focusColor?.value,
    'hoverColor': theme?.hoverColor?.value,
    'foregroundColor': theme?.foregroundColor?.value,
    'splashColor': theme?.splashColor?.value,
    'disabledElevation': theme?.disabledElevation,
    'elevation': theme.elevation,
    'focusElevation': theme.focusElevation,
    'highlightElevation': theme.highlightElevation,
    'hoverElevation': theme.hoverElevation,
    'shape': shapeToMap(theme.shape),
  };
}

FloatingActionButtonThemeData floatingActionButtonThemeFromMap(
    Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return FloatingActionButtonThemeData(
    backgroundColor: getColorFromMap(data['backgroundColor']),
    focusColor: getColorFromMap(data['focusColor']),
    foregroundColor: getColorFromMap(data['foregroundColor']),
    hoverColor: getColorFromMap(data['hoverColor']),
    splashColor: getColorFromMap(data['splashColor']),
    disabledElevation: data['disabledElevation'],
    elevation: data['elevation'],
    focusElevation: data['focusElevation'],
    highlightElevation: data['highlightElevation'],
    hoverElevation: data['hoverElevation'],
    shape: shapeFromMap(data['shape']),
  );
}

/// Tester si l'iconThemeDate est null
bool floatingActionButtonThemeDataIsNull(FloatingActionButtonThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }
  objectIsNull = theme.backgroundColor == null &&
      theme.focusColor == null &&
      theme.foregroundColor == null &&
      theme.hoverColor == null &&
      theme.splashColor == null &&
      theme.disabledElevation == null &&
      theme.elevation == null &&
      theme.focusElevation == null &&
      theme.highlightElevation == null &&
      theme.hoverElevation == null &&
      theme.splashColor == null &&
      theme.shape == null;
  return objectIsNull;
}
