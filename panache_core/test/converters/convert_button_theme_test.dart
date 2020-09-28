import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panache_core/src/converters/button_theme_converters.dart';
import 'package:panache_core/src/converters/converter_utils.dart';

import 'mock_button_theme.dart';

void main() {
  ButtonThemeData buttonTheme;

  group('convert buttonTheme', () {
    /*setUp(() {
      ThemeData  theme = ThemeData.light();
      buttonTheme = theme.buttonTheme;
    });*/

    test('buttonShapeToCode', () {
      expect(
          shapeToCode(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
          roundedRectangleBorderCode);
      expect(shapeToCode(BeveledRectangleBorder()), beveledRectangleBorderCode);
      expect(shapeToCode(StadiumBorder()), stadiumBorderCode);
      expect(shapeToCode(CircleBorder()), circleBorderCode);
    });

    test('buttonShapeToCode - with border', () {
      expect(
          shapeToCode(
            RoundedRectangleBorder(
              side: BorderSide(color: Color(0xff000000), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          roundedRectangleBorderSideCode);

      expect(
          shapeToCode(BeveledRectangleBorder(
              side: BorderSide(color: Color(0xff000000), width: 1))),
          beveledRectangleBorderSideCode);

      expect(
          shapeToCode(StadiumBorder(
              side: BorderSide(color: Color(0xff000000), width: 1))),
          stadiumRectangleBorderSideCode);

      expect(
          shapeToCode(CircleBorder(
              side: BorderSide(color: Color(0xff000000), width: 1))),
          circleBorderSideCode);
    });
  });
}
