import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/converter_utils.dart';

import 'constants.dart';

enum RGB { R, G, B }

enum HSL { H, S, L }

const List<String> materialColorsNames = <String>[
  "red",
  "pink",
  "purple",
  "deepPurple",
  "indigo",
  "blue",
  "lightBlue",
  "cyan",
  "teal",
  "green",
  "lightGreen",
  "lime",
  "yellow",
  "amber",
  "orange",
  "deepOrange",
  "brown",
  "blueGrey",
  "White",
  "Black",
  "Grey"
];

Color getMaterialColor(String name) => namedColors()
    .firstWhere((NamedColor color) => color.name == name,
        orElse: () =>
            NamedColor(name: name, color: Color(int.parse(name, radix: 16))))
    .color;

String getMaterialName(Color color) => namedColors()
    .firstWhere(
        (NamedColor colorNamed) => colorNamed.color?.value == color?.value,
        orElse: () =>
            NamedColor(name: color?.value.toRadixString(16), color: color))
    .name;

bool isMaterialPrimary(Color color) => namedColors()
    .where((NamedColor colorNamed) => colorNamed.color?.value == color?.value)
    .isNotEmpty;

/// look for the corresponding mmaterialColor or return a generated ColorSwatch
/// based on the selected color
///
MaterialColor swatchFor({Color color}) => Colors.primaries.firstWhere(
    (MaterialColor matColor) => matColor?.value == color?.value,
    orElse: () => newColorSwatch(color));

String materialSwatchCodeFor({Color color}) {
  return namedColors()
          .firstWhere(
              (NamedColor namedColor) =>
                  namedColor.color?.value == color?.value,
              orElse: () => null)
          ?.toString() ??
      customSwatchCode(color);
}

String customSwatchCode(Color color) {
  Map<int, String> shadesCode = getMaterialColorValues(color).map(
      (int k, Color v) => MapEntry<int, String>(k, "${colorToCode(v)}\n\t\t"));
  return "MaterialColor(${color?.value},$shadesCode)";
}

List<NamedColor> namedColors() {
  List<Color> colors = List<Color>.from(Colors.primaries);
  colors.addAll([white, black, grey]);

  return colors.fold(
      [],
      (cumul, current) => cumul
        ..add(NamedColor(
            name: materialColorsNames[cumul.length], color: current)));
}

class NamedColor {
  final String name;
  final Color color;

  NamedColor({@required this.name, @required this.color});

  @override
  String toString() {
    return 'Colors.$name';
  }
}

bool isDark(Color color) => (color.red + color.green + color.blue) / 3 >= 146;

Color getContrastColor(Color c, {int limit: 450}) =>
    c.red + c.green + c.blue < limit ? Colors.white : Colors.black;

List<Widget> getMaterialSwatches(ValueChanged<Color> onSelection) {
  final colors = Colors.primaries.map((Color color) => color).toList();
  colors.addAll([white, black, grey]);

  return colors
      .map((dynamic color) => InkWell(
            child: Padding(
                padding: EdgeInsets.all(4),
                child: Container(
                    width: kSwatchSize, height: kSwatchSize, color: color)),
            onTap: () => onSelection(color),
          ))
      .toList();
}

///
/// MaterialColor/ColorSwatch from simple color
///
MaterialColor newColorSwatch(Color color, {bool opaque: true}) {
  //final c = opaque ? color.withOpacity(1) : color;
  final swatch = getMaterialColorValues(color);
  return new MaterialColor(color.value, swatch);
}

///
/// get list of material color shades from simple [Color]
///
Map<int, Color> getMaterialColorValues(Color primary) => <int, Color>{
      50: getSwatchShade(primary, 50),
      100: getSwatchShade(primary, 100),
      200: getSwatchShade(primary, 200),
      300: getSwatchShade(primary, 300),
      400: getSwatchShade(primary, 400),
      500: getSwatchShade(primary, 500),
      600: getSwatchShade(primary, 600),
      700: getSwatchShade(primary, 700),
      800: getSwatchShade(primary, 800),
      900: getSwatchShade(primary, 900),
    };

///
/// color a color shade for material swatch value
Color getSwatchShade(Color c, int swatchValue) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness(1 - (swatchValue / 1000)).toColor();
}

/// return a list of all color of a materialColor
List<Color> getMaterialColorShades(MaterialColor color) => [
      color[50],
      color[100],
      color[200],
      color[300],
      color[400],
      color[500],
      color[600],
      color[700],
      color[800],
      color[900]
    ];

String colorToHex32(Color color) =>
    '#${color?.value.toRadixString(16).padLeft(8, '0')}';

String colorToInt(Color color) =>
    '0x${color?.value.toRadixString(16).padLeft(8, '0')}';

List<Color> getHueGradientColors({int steps: 36}) =>
    List.generate(steps, (value) => value).map<Color>((v) {
      final hsl = HSLColor.fromAHSL(1, v * (360 / steps), 0.67, 0.50);
      final rgb = hsl.toColor();
      return rgb.withOpacity(1);
    }).toList();

Color getMinSaturation(Color color) {
  final hsl = HSLColor.fromColor(color);
  final minS = hsl.withSaturation(0);
  return minS.toColor().withOpacity(1);
}

Color getMaxSaturation(Color color) =>
    HSLColor.fromColor(color).withSaturation(1).toColor();

const MaterialColor grey = MaterialColor(
  _greyPrimaryValue,
  <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF0F0F0),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFCCCCCC),
    400: Color(0xFFAAAAAA),
    500: Color(_greyPrimaryValue),
    600: Color(0xFF666666),
    700: Color(0xFF404040),
    800: Color(0xFF303030),
    900: Color(0xFF202020),
  },
);
const int _greyPrimaryValue = 0xFF999999;

const MaterialColor white = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
const int _whitePrimaryValue = 0xFFFFFFFF;

const MaterialColor black = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
