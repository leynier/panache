import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'bottomSheetTheme';

class BottomSheetThemePanel extends StatelessWidget {
  final ThemeModel model;
  const BottomSheetThemePanel(this.model, {Key key}) : super(key: key);
  BottomSheetThemeData get currentTheme => myTheme.bottomSheetTheme;

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
                currentTheme.backgroundColor ?? myTheme.backgroundColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'modalBackgroundColor',
                currentTheme.modalBackgroundColor ?? Colors.transparent,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(modalBackgroundColor: color)),
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
            SliderPropertyControl(
              currentTheme.modalElevation ?? 1,
              (double value) => _updateCurrentTheme(
                  currentTheme.copyWith(modalElevation: value)),
              label: 'modalElevation',
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
          ]),
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

  void _updateCurrentTheme(BottomSheetThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(bottomSheetTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
  }
}
