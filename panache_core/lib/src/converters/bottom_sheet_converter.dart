import 'package:flutter/material.dart';

import 'converter_utils.dart';

String bottomSheetThemeToCode(
  BottomSheetThemeData theme,
) {
  return '''
  BottomSheetThemeData(
      backgroundColor: ${colorToCode(theme.backgroundColor)},
      modalBackgroundColor: ${colorToCode(theme.modalBackgroundColor)},
      elevation: ${theme.elevation},
      modalElevation: ${theme.modalElevation},
      shape: ${shapeToCode(theme.shape)} ,
    )''';
}

Map<String, dynamic> bottomSheetThemeToMap(
  BottomSheetThemeData theme,
) {
  return <String, dynamic>{
    'backgroundColor': theme.backgroundColor?.value,
    'modalBackgroundColor': theme.modalBackgroundColor?.value,
    'elevation': theme.elevation,
    'modalElevation': theme.modalElevation,
    'shape': shapeToMap(theme.shape),
  };
}

BottomSheetThemeData bottomSheetThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return BottomSheetThemeData(
    backgroundColor: getColorFromMap(data['backgroundColor']),
    modalBackgroundColor: getColorFromMap(data['modalBackgroundColor']),
    elevation: data['elevation'],
    modalElevation: data['modalElevation'],
    shape: shapeFromMap(data['shape']),
  );
}

/// Tester si l'iconThemeDate est null
bool bottomSheetThemeDataIsNull(BottomSheetThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.clipBehavior == null &&
      theme.backgroundColor == null &&
      theme.elevation == null &&
      theme.modalBackgroundColor == null &&
      theme.modalElevation == null &&
      theme.shape == null;
  return objectIsNull;
}
