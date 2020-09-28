import 'dart:math';

import 'package:flutter/material.dart';

import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String chipThemeToCode(ChipThemeData chipTheme,
    {@required TextStyle defaultLabelStyle}) {
  return '''
  ChipThemeData(
      backgroundColor: ${colorToCode(chipTheme.backgroundColor)},
      brightness: ${chipTheme.brightness},
      deleteIconColor: ${colorToCode(chipTheme.deleteIconColor)},
      disabledColor: ${colorToCode(chipTheme.disabledColor)},
      labelPadding: ${paddingToCode(chipTheme.labelPadding)},
      labelStyle: ${textStyleToCode(
    defaultLabelStyle.merge(chipTheme.labelStyle),
  )},
      padding: ${paddingToCode(chipTheme.padding)},
      secondaryLabelStyle: ${textStyleToCode(
    defaultLabelStyle.merge(
      chipTheme.labelStyle.copyWith(color: chipTheme.selectedColor),
    ),
  )},
      secondarySelectedColor: ${colorToCode(chipTheme.secondarySelectedColor)},
      selectedColor: ${colorToCode(chipTheme.selectedColor)},
      shape: ${shapeToCode(chipTheme.shape)},
      checkmarkColor: ${colorToCode(chipTheme.checkmarkColor)},
      showCheckmark: ${chipTheme.showCheckmark},
      selectedShadowColor: ${colorToCode(chipTheme.selectedShadowColor)},
      shadowColor: ${colorToCode(chipTheme.shadowColor)},
      elevation: ${chipTheme.elevation},
      pressElevation: ${chipTheme.pressElevation},
    )''';
}

Map<String, dynamic> chipThemeToMap(ChipThemeData chipTheme,
    {@required TextStyle defaultLabelStyle}) {
  return {
    'backgroundColor': chipTheme.backgroundColor?.value,
    'brightness': max(0, Brightness.values.indexOf(chipTheme.brightness)),
    'deleteIconColor': chipTheme.deleteIconColor?.value,
    'disabledColor': chipTheme.disabledColor?.value,
    'labelPadding': paddingToMap(chipTheme.labelPadding),
    'labelStyle': textStyleToMap(
      defaultLabelStyle.merge(chipTheme.labelStyle),
    ),
    'padding': paddingToMap(chipTheme.padding),
    'secondaryLabelStyle': textStyleToMap(defaultLabelStyle
        .merge(chipTheme.labelStyle.copyWith(color: chipTheme.selectedColor))),
    'secondarySelectedColor': chipTheme.secondarySelectedColor?.value,
    'selectedColor': chipTheme.selectedColor?.value,
    'shape': shapeToMap(chipTheme.shape),
    'checkmarkColor': chipTheme.checkmarkColor?.value,
    'showCheckmark': chipTheme.showCheckmark,
    'shadowColor': chipTheme.shadowColor?.value,
    'selectedShadowColor': chipTheme.selectedShadowColor?.value,
    'elevation': chipTheme.elevation,
    'pressElevation': chipTheme.pressElevation,
  };
}

ChipThemeData chipThemeFromMap(Map<String, dynamic> data,
    {@required Brightness brightness,
    @required Color secondaryColor,
    @required TextStyle labelStyle}) {
  if (data == null) {
    return null;
  }
  return ChipThemeData.fromDefaults(
          brightness: brightness,
          secondaryColor: secondaryColor,
          labelStyle: labelStyle)
      .copyWith(
    backgroundColor: getColorFromMap(data['backgroundColor']),
    brightness: Brightness.values[max(0, data['brightness'])],
    deleteIconColor: getColorFromMap(data['deleteIconColor']),
    disabledColor: getColorFromMap(data['disabledColor']),
    labelPadding: paddingFromMap(data['labelPadding']),
    labelStyle: textStyleFromMap(data['labelStyle']),
    padding: paddingFromMap(data['padding']),
    secondaryLabelStyle: textStyleFromMap(data['secondaryLabelStyle']),
    secondarySelectedColor: getColorFromMap(data['secondarySelectedColor']),
    selectedColor: getColorFromMap(data['selectedColor']),
    shape: shapeFromMap(data['shape']),
    checkmarkColor: getColorFromMap(data['checkmarkColor']),
    //showCheckmark: data['showCheckmark'],
    selectedShadowColor: getColorFromMap(data['selectedShadowColor']),
    shadowColor: getColorFromMap(data['shadowColor']),
    elevation: data['elevation'],
    pressElevation: data['pressElevation'],
  );
}
