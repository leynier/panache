import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String materialBannerThemeToCode(
  MaterialBannerThemeData theme,
) {
  return '''
  MaterialBannerThemeData(
      backgroundColor: ${colorToCode(theme.backgroundColor)},
      contentTextStyle: ${textStyleToCode(theme.contentTextStyle)},
    )''';
}

Map<String, dynamic> materialBannerThemeToMap(
  MaterialBannerThemeData theme,
) {
  return <String, dynamic>{
    'backgroundColor': theme.backgroundColor?.value,
    'contentTextStyle': textStyleToMap(theme.contentTextStyle),
  };
}

MaterialBannerThemeData materialBannerThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return MaterialBannerThemeData(
    backgroundColor: getColorFromMap(data['backgroundColor']),
    contentTextStyle: textStyleFromMap(data['contentTextStyle']),
  );
}

/// Tester si l'iconThemeDate est null
bool materialBannerThemeDataIsNull(MaterialBannerThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.backgroundColor == null &&
      textStyleIsNull(theme.contentTextStyle) == true &&
      theme.leadingPadding == null &&
      theme.padding == null;
  return objectIsNull;
}
