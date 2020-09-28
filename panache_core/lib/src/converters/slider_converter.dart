import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_core/src/converters/converter_utils.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

String sliderThemeToCode(
    SliderThemeData sliderTheme, TextStyle defaultValueIndicatorStyle) {
  return '''
  SliderThemeData(
      activeTrackColor: ${colorToCode(sliderTheme.activeTrackColor)},
      inactiveTrackColor: ${colorToCode(sliderTheme.inactiveTrackColor)},
      disabledActiveTrackColor: ${colorToCode(sliderTheme.disabledActiveTrackColor)},
      disabledInactiveTrackColor: ${colorToCode(sliderTheme.disabledInactiveTrackColor)},
      activeTickMarkColor: ${colorToCode(sliderTheme.activeTickMarkColor)},
      inactiveTickMarkColor: ${colorToCode(sliderTheme.inactiveTickMarkColor)},
      disabledActiveTickMarkColor: ${colorToCode(sliderTheme.disabledActiveTickMarkColor)},
      disabledInactiveTickMarkColor: ${colorToCode(sliderTheme.disabledInactiveTickMarkColor)},
      thumbColor: ${colorToCode(sliderTheme.thumbColor)},
      disabledThumbColor: ${colorToCode(sliderTheme.disabledThumbColor)},
      thumbShape: ${instanceToCode(sliderTheme.thumbShape)},
      overlayColor: ${colorToCode(sliderTheme.overlayColor)},
      valueIndicatorColor: ${colorToCode(sliderTheme.valueIndicatorColor)},
      valueIndicatorShape: ${instanceToCode(sliderTheme.valueIndicatorShape)},
      showValueIndicator: ${sliderTheme.showValueIndicator},
      valueIndicatorTextStyle: ${textStyleToCode(defaultValueIndicatorStyle.merge(sliderTheme.valueIndicatorTextStyle))},
      trackHeight: ${sliderTheme.trackHeight},
      minThumbSeparation: ${sliderTheme.minThumbSeparation},
    )''';
}

Map<String, dynamic> sliderThemeToMap(
    SliderThemeData sliderTheme, TextStyle defaultValueIndicatorStyle) {
  return <String, dynamic>{
    'activeTrackColor': sliderTheme.activeTrackColor?.value,
    'inactiveTrackColor': sliderTheme.inactiveTrackColor?.value,
    'disabledActiveTrackColor': sliderTheme.disabledActiveTrackColor?.value,
    'disabledInactiveTrackColor': sliderTheme.disabledInactiveTrackColor?.value,
    'activeTickMarkColor': sliderTheme.activeTickMarkColor?.value,
    'inactiveTickMarkColor': sliderTheme.inactiveTickMarkColor?.value,
    'disabledActiveTickMarkColor':
        sliderTheme.disabledActiveTickMarkColor?.value,
    'disabledInactiveTickMarkColor':
        sliderTheme.disabledInactiveTickMarkColor?.value,
    'thumbColor': sliderTheme.thumbColor?.value,
    'disabledThumbColor': sliderTheme.disabledThumbColor?.value,
    'thumbShape': <String, dynamic>{'type': 'RoundSliderThumbShape'},
    'overlayColor': sliderTheme.overlayColor?.value,
    'valueIndicatorColor': sliderTheme.valueIndicatorColor?.value,
    'valueIndicatorShape': <String, dynamic>{
      'type': 'PaddleSliderValueIndicatorShape'
    },
    'showValueIndicator': max(
        0, ShowValueIndicator.values.indexOf(sliderTheme.showValueIndicator)),
    'valueIndicatorTextStyle': textStyleToMap(
        defaultValueIndicatorStyle.merge(sliderTheme.valueIndicatorTextStyle)),
    'trackHeight': sliderTheme.trackHeight,
    'minThumbSeparation': sliderTheme.minThumbSeparation,
  };
}

SliderThemeData sliderThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return SliderThemeData(
    activeTrackColor: getColorFromMap(data['activeTrackColor']),
    inactiveTrackColor: getColorFromMap(data['inactiveTrackColor']),
    disabledActiveTrackColor: getColorFromMap(data['disabledActiveTrackColor']),
    disabledInactiveTrackColor:
        getColorFromMap(data['disabledInactiveTrackColor']),
    activeTickMarkColor: getColorFromMap(data['activeTickMarkColor']),
    inactiveTickMarkColor: getColorFromMap(data['inactiveTickMarkColor']),
    disabledActiveTickMarkColor:
        getColorFromMap(data['disabledActiveTickMarkColor']),
    disabledInactiveTickMarkColor:
        getColorFromMap(data['disabledInactiveTickMarkColor']),
    thumbColor: getColorFromMap(data['thumbColor']),
    disabledThumbColor: getColorFromMap(data['disabledThumbColor']),
    thumbShape: const RoundSliderThumbShape(),
    overlayColor: getColorFromMap(data['overlayColor']),
    valueIndicatorColor: getColorFromMap(data['valueIndicatorColor']),
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    showValueIndicator:
        ShowValueIndicator.values[max(0, data['showValueIndicator'])],
    valueIndicatorTextStyle: textStyleFromMap(data['valueIndicatorTextStyle']),
    trackHeight: data['trackHeight'],
    minThumbSeparation: data['minThumbSeparation'],
  );
}
