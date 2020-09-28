import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'floatActionTheme';

class FloatActionThemePanel extends StatelessWidget {
  final ThemeModel model;
  const FloatActionThemePanel(this.model, {Key key}) : super(key: key);
  FloatingActionButtonThemeData get currentTheme =>
      myTheme.floatingActionButtonTheme;
  ThemeData get myTheme => model.theme;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'backgroundColor',
                currentTheme.backgroundColor ??
                    model.theme.colorScheme.secondary,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'focusColor',
                currentTheme.focusColor ?? model.theme.focusColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(focusColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'foregroundColor',
                currentTheme.foregroundColor ??
                    model.theme.colorScheme.onSecondary,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(foregroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'hoverColor ',
                currentTheme.hoverColor ?? model.theme.hoverColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(hoverColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'splashColor',
                currentTheme.splashColor ?? model.theme.splashColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(splashColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SliderPropertyControl(
                currentTheme.disabledElevation ?? 1,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(disabledElevation: value)),
                label: 'disabledElevation',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                currentTheme.elevation ?? 1,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(elevation: value)),
                label: 'Elevation',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
              SliderPropertyControl(
                currentTheme.focusElevation ?? 1,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(focusElevation: value)),
                label: 'focusElevation',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                currentTheme.highlightElevation ?? 1,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(highlightElevation: value)),
                label: 'highlightElevation',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
              SliderPropertyControl(
                currentTheme.hoverElevation ?? 1,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(hoverElevation: value)),
                label: 'hoverElevation',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
          getFieldsRow(<Widget>[
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

  void _updateCurrentTheme(FloatingActionButtonThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme =
        model.theme.copyWith(floatingActionButtonTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
  }
}
