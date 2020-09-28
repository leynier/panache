import 'dart:math';

import 'package:flutter/material.dart';

Color getColorFromMap(dynamic color) {
  if (color == null) {
    return null;
  }
  return Color(color);
}

String paddingToCode(EdgeInsets padding) {
  EdgeInsets paddingTmp;
  if (padding == null) {
    return 'null';
  }
  paddingTmp ??= EdgeInsets.zero;
  return 'EdgeInsets.only('
      'top:${padding.top},'
      'bottom:${padding.bottom},'
      'left:${padding.left}, '
      'right:${padding.right}'
      ')';
}

Map<String, dynamic> paddingToMap(EdgeInsets padding) {
  EdgeInsets paddingTmp;
  if (padding == null) {
    return null;
  }
  paddingTmp ??= EdgeInsets.zero;
  return <String, dynamic>{
    'top': padding.top.toInt(),
    'right': padding.right.toInt(),
    'bottom': padding.bottom.toInt(),
    'left': padding.left.toInt(),
  };
}

EdgeInsetsGeometry paddingFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  EdgeInsets.only(
    left: (data['left'] as int).toDouble(),
    top: (data['top'] as int).toDouble(),
    right: (data['right'] as int).toDouble(),
    bottom: (data['bottom'] as int).toDouble(),
  );
}

String colorToCode(Color color) {
  if (color == null) {
    return 'null';
  }
  return 'Color( 0x${color?.value.toRadixString(16).padLeft(8, '0')} )';
}

String colorSchemeToCode(ColorScheme scheme) {
  return '''
  ColorScheme(
        primary: ${colorToCode(scheme.primary)},
        primaryVariant: ${colorToCode(scheme.primaryVariant)},
        secondary: ${colorToCode(scheme.secondary)},
        secondaryVariant: ${colorToCode(scheme.secondaryVariant)},
        surface: ${colorToCode(scheme.surface)},
        background: ${colorToCode(scheme.background)},
        error: ${colorToCode(scheme.error)},
        onPrimary: ${colorToCode(scheme.onPrimary)},
        onSecondary: ${colorToCode(scheme.onSecondary)},
        onSurface: ${colorToCode(scheme.onSurface)},
        onBackground: ${colorToCode(scheme.onBackground)},
        onError: ${colorToCode(scheme.onError)},
        brightness: ${scheme.brightness},
      )''';
}

Map<String, dynamic> colorSchemeToMap(ColorScheme scheme) {
  if (scheme == null) {
    return null;
  }
  return <String, dynamic>{
    'primary': scheme.primary.value,
    'primaryVariant': scheme.primaryVariant.value,
    'secondary': scheme.secondary.value,
    'secondaryVariant': scheme.secondaryVariant.value,
    'surface': scheme.surface.value,
    'background': scheme.background.value,
    'error': scheme.error.value,
    'onPrimary': scheme.onPrimary.value,
    'onSecondary': scheme.onSecondary.value,
    'onSurface': scheme.onSurface.value,
    'onBackground': scheme.onBackground.value,
    'onError': scheme.onError.value,
    'brightness': max(0, Brightness.values.indexOf(scheme.brightness)),
  };
}

ColorScheme colorSchemeFromMap(Map<String, dynamic> data) {
  return ColorScheme(
    primary: getColorFromMap(data['primary']),
    primaryVariant: getColorFromMap(data['primaryVariant']),
    secondary: getColorFromMap(data['secondary']),
    secondaryVariant: getColorFromMap(data['secondaryVariant']),
    surface: getColorFromMap(data['surface']),
    background: getColorFromMap(data['background']),
    error: getColorFromMap(data['error']),
    onPrimary: getColorFromMap(data['onPrimary']),
    onSecondary: getColorFromMap(data['onSecondary']),
    onSurface: getColorFromMap(data['onSurface']),
    onBackground: getColorFromMap(data['onBackground']),
    onError: getColorFromMap(data['onError']),
    brightness: Brightness.values[max(0, data['brightness'])],
  );
}

Map<String, dynamic> borderRadiusToMap(BorderRadiusGeometry radius) {
  if (radius == null) {
    return null;
  }
  BorderRadius borderRadius = radius as BorderRadius;
  return <String, dynamic>{
    'topLeft': {'x': borderRadius.topLeft.x, 'y': borderRadius.topLeft.y},
    'topRight': {'x': borderRadius.topRight.x, 'y': borderRadius.topRight.y},
    'bottomLeft': {
      'x': borderRadius.bottomLeft.x,
      'y': borderRadius.bottomLeft.y
    },
    'bottomRight': {
      'x': borderRadius.bottomRight.x,
      'y': borderRadius.bottomRight.y
    },
  };
}

String borderSideToCode(BorderSide side) {
  if (side == null) {
    return 'null';
  }
  return 'BorderSide(color: ${colorToCode(side.color)}, width: ${side.width}, style: ${side.style}, )';
}

Map<String, dynamic> borderSideToMap(BorderSide side) {
  if (side == null) {
    return null;
  }
  return <String, dynamic>{
    'color': side.color?.value,
    'width': side.width.toStringAsFixed(0),
    'style': max(0, BorderStyle.values.indexOf(side.style)),
  };
}

BorderRadius borderRadiusFromMap(Map<String, dynamic> data) {
  return BorderRadius.only(
    topLeft: Radius.circular(data['topLeft']['x']),
    topRight: Radius.circular(data['topRight']['x']),
    bottomLeft: Radius.circular(data['bottomLeft']['x']),
    bottomRight: Radius.circular(data['bottomRight']['x']),
  );
}

BorderSide borderSideFromMap(dynamic data) {
  if (data == null || data == 'none') {
    return BorderSide.none;
  }
  return BorderSide(
    color: getColorFromMap(data['color']),
    width: double.parse(data['width']) ?? 1,
    style: BorderStyle.values[max(0, data['style'])],
  );
}

String getShapeBorderType(ShapeBorder border) {
  if (border is RoundedRectangleBorder) {
    return 'RoundedRectangleBorder';
  }

  if (border is StadiumBorder) {
    return 'StadiumBorder';
  }
  if (border is CircleBorder) {
    return 'CircleBorder';
  }
  if (border is BeveledRectangleBorder) {
    return 'BeveledRectangleBorder';
  }

  return 'RoundedRectangleBorder';
}

Map<String, dynamic> shapeToMap(ShapeBorder border) {
  if (border == null) {
    return null;
  }
  String type = getShapeBorderType(border);

  if (border is RoundedRectangleBorder) {
    return <String, dynamic>{
      'type': type,
      'radius': borderRadiusToMap(border.borderRadius),
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  if (border is BeveledRectangleBorder) {
    return <String, dynamic>{
      'type': type,
      'radius': borderRadiusToMap(border.borderRadius),
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  if (border is StadiumBorder) {
    return <String, dynamic>{
      'type': type,
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  if (border is CircleBorder) {
    return <String, dynamic>{
      'type': type,
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  return <String, dynamic>{
    'type': type,
  };
}

String shapeToCode(ShapeBorder border) {
  if (border is RoundedRectangleBorder) {
    return '''
    RoundedRectangleBorder(
      side: ${borderSideToCode(border.side)},
      borderRadius: BorderRadius.all(${(border.borderRadius as BorderRadius).topLeft}),
    )
''';
  }

  if (border is BeveledRectangleBorder) {
    return '''
    BeveledRectangleBorder(
      side: ${borderSideToCode(border.side)},
      borderRadius: BorderRadius.all(${(border.borderRadius as BorderRadius).topLeft}),
    )
''';
  }

  if (border is StadiumBorder) {
    return '''StadiumBorder( side: ${borderSideToCode(border.side)} )''';
  }

  if (border is CircleBorder) {
    return '''CircleBorder( side: ${borderSideToCode(border.side)} )''';
  }

  return 'null';
}

ShapeBorder shapeFromMap(Map<String, dynamic> data) {
  if (data['type'] == 'RoundedRectangleBorder') {
    return RoundedRectangleBorder(
        borderRadius: borderRadiusFromMap(data['radius']),
        side: borderSideFromMap(data['side']));
  }

  if (data['type'] == 'BeveledRectangleBorder') {
    return BeveledRectangleBorder(
        borderRadius: borderRadiusFromMap(data['radius']),
        side: borderSideFromMap(data['side']));
  }

  if (data['type'] == 'StadiumBorder') {
    return StadiumBorder(side: borderSideFromMap(data['side']));
  }

  if (data['type'] == 'CircleBorder') {
    return CircleBorder(side: borderSideFromMap(data['side']));
  }

  return const RoundedRectangleBorder();
}

TextDecoration decorationFromMap(String decoration) {
  TextDecoration value;
  if (decoration == null) {
    return null;
  }
  switch (decoration?.toLowerCase()) {
    case 'texttecoration.underline':
      value = TextDecoration.underline;
      break;
    case 'texttecoration.overline':
      value = TextDecoration.overline;
      break;
    case 'texttecoration.lineThrough':
      value = TextDecoration.lineThrough;
      break;
    case 'texttecoration.none':
    default:
      value = TextDecoration.none;
      break;
  }

  return value;
}
