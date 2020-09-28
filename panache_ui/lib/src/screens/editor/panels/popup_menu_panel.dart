import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'popupMenuTheme';

class PopupMenuThemePanel extends StatelessWidget {
  final ThemeModel model;
  const PopupMenuThemePanel(this.model, {Key key}) : super(key: key);
  PopupMenuThemeData get currentTheme => myTheme.popupMenuTheme;

  ThemeData get myTheme => model.theme;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    TextStyle textStyle = currentTheme.textStyle ?? createDefaultTextStyle();
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'Color',
                currentTheme.color ?? myTheme.primaryColor,
                (Color color) =>
                    _updateCurrentTheme(currentTheme.copyWith(color: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SliderPropertyControl(
                currentTheme.elevation ?? 1,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(elevation: value)),
                label: 'Elevation',
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
          const Divider(
            height: 32,
          ),
          Text('textStyle', style: appTextTheme.subtitle1),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'textstyle',
            textStyle: textStyle,
            label: 'textStyle',
            styleName: 'textStyle',
          ),
        ],
      ),
    );
  }

  void _onBrightnessChanged(Brightness value, {TextStyle labelStyle}) {
    ThemeData updatedTheme = model.theme.copyWith(
      brightness: value,
    );
    model.updateTheme(updatedTheme);
  }

  void _updateCurrentTheme(PopupMenuThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(popupMenuTheme: theme);

    model.updateTheme(updatedTheme);
  }
}
