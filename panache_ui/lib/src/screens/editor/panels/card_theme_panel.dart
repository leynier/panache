import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'cardTheme';

class CardThemePanel extends StatelessWidget {
  final ThemeModel model;
  CardTheme get currentTheme => myTheme.cardTheme;
  const CardThemePanel(this.model, {Key key}) : super(key: key);

  ThemeData get myTheme => model.theme;

  @override
  Widget build(BuildContext context) {
    //TextTheme appTextTheme = Theme.of(context).textTheme;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'Color',
                currentTheme.color ?? myTheme.cardColor,
                (Color color) =>
                    _updateCurrentTheme(currentTheme.copyWith(color: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'shadowColor',
                currentTheme.shadowColor ?? myTheme.shadowColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(shadowColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          const Divider(
            height: 32,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              currentTheme.elevation ?? 1,
              (double value) =>
                  _updateCurrentTheme(currentTheme.copyWith(elevation: value)),
              label: 'Elevation',
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
            ShapeFormControl(
              onShapeChanged: (ShapeBorder shape) =>
                  _updateCurrentTheme(currentTheme.copyWith(shape: shape)),
              shape: currentTheme.shape,
              //labelStyle: labelStyle,
              direction: Axis.vertical,
            )
          ]),
        ],
      ),
    );
  }

  void _updateCurrentTheme(CardTheme theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(cardTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
    properties
        .add(DiagnosticsProperty<CardTheme>('currentTheme', currentTheme));
  }
}
