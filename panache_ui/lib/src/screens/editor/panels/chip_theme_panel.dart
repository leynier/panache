import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';

import '../controls/color_selector.dart';
import '../controls/shape_form_control.dart';
import '../controls/switcher_control.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

String _themeRef = 'chipTheme';

class ChipThemePanel extends StatelessWidget {
  final ThemeModel model;

  ChipThemeData get chipTheme => model.theme.chipTheme;

  const ChipThemePanel(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    TextStyle labelStyle = appTextTheme.subtitle2;
    TextStyle chipLabelStyle = chipTheme.labelStyle;
    TextStyle secondaryLabelStyle =
        chipTheme.secondaryLabelStyle ?? createDefaultTextStyle();

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          ColorSelector(
            'Background color',
            model.theme.chipTheme.backgroundColor,
            (Color color) =>
                _updateChipTheme(chipTheme.copyWith(backgroundColor: color)),
            padding: 2,
            maxLabelWidth: 250,
          ),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Secondary selected color',
              model.theme.chipTheme.secondarySelectedColor,
              (Color color) => _updateChipTheme(
                  chipTheme.copyWith(secondarySelectedColor: color)),
              padding: 2,
            ),
            ColorSelector(
              'Selected color',
              model.theme.chipTheme.selectedColor,
              (Color color) =>
                  _updateChipTheme(chipTheme.copyWith(selectedColor: color)),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Disabled color',
              model.theme.chipTheme.disabledColor,
              (Color color) =>
                  _updateChipTheme(chipTheme.copyWith(disabledColor: color)),
              padding: 2,
            ),
            ColorSelector(
              'Delete icon color',
              model.theme.chipTheme.deleteIconColor,
              (Color color) =>
                  _updateChipTheme(chipTheme.copyWith(deleteIconColor: color)),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'checkmarkColor',
              model.theme.chipTheme.checkmarkColor,
              (Color color) =>
                  _updateChipTheme(chipTheme.copyWith(checkmarkColor: color)),
              padding: 2,
            ),
            /*SwitcherControl(
              label: 'showCheckmark',
              checked: model.theme.chipTheme.showCheckmark,
              direction: Axis.vertical,
              onChange: (bool value) =>
                  _updateChipTheme(chipTheme.copyWith(showCheckmark: value)),
            ),*/
          ]),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              model.theme.chipTheme.elevation ?? 0,
              (double elevation) =>
                  _updateChipTheme(chipTheme.copyWith(elevation: elevation)),
              label: 'Elevation',
              max: 20,
              maxWidth: 20,
              vertical: true,
            ),
            SliderPropertyControl(
              model.theme.chipTheme.pressElevation ?? 8,
              (double elevation) => _updateChipTheme(
                  chipTheme.copyWith(pressElevation: elevation)),
              label: 'pressElevation',
              max: 20,
              maxWidth: 20,
              vertical: true,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'shadowColor',
              model.theme.chipTheme.shadowColor,
              (Color color) =>
                  _updateChipTheme(chipTheme.copyWith(shadowColor: color)),
              padding: 2,
            ),
            ColorSelector(
              'selectedShadowColor',
              model.theme.chipTheme.selectedShadowColor,
              (Color color) => _updateChipTheme(
                  chipTheme.copyWith(selectedShadowColor: color)),
              padding: 2,
            ),
          ]),
          const Divider(),
          buildTextStyleControl(
            _themeRef,
            model,
            chipTheme.copyWith,
            key: 'chip_textstyle',
            textStyle: chipLabelStyle,
            label: 'Label Style',
            styleName: 'labelStyle',
          ),
          const Divider(),
          buildTextStyleControl(
            _themeRef,
            model,
            chipTheme.copyWith,
            key: 'chip_alternative_textstyle',
            textStyle: secondaryLabelStyle,
            label: 'Secondary Label Style',
            styleName: 'secondaryLabelStyle',
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ShapeFormControl(
                  onShapeChanged: (shapeBorder) =>
                      _updateChipTheme(chipTheme.copyWith(shape: shapeBorder)),
                  shape: chipTheme.shape,
                  labelStyle: labelStyle),
              SwitcherControl(
                checked: chipTheme.brightness == Brightness.dark,
                checkedLabel: 'Dark',
                direction: Axis.vertical,
                onChange: (bool value) => _onBrightnessChanged(
                    value ? Brightness.dark : Brightness.light,
                    labelStyle: appTextTheme.bodyText2),
              ),
              /*Expanded(
                child: BrightnessSelector(
                  label: 'Brightness',
                  direction: Axis.horizontal,
                  isDark: chipTheme.brightness == Brightness.dark,
                  onBrightnessChanged: (value) => _onBrightnessChanged(value,
                      labelStyle: appTextTheme.bodyText2),
                ),
              )*/
            ],
          ),
        ],
      ),
    );
  }

  void _onBrightnessChanged(Brightness value, {TextStyle labelStyle}) {
    ThemeData updatedTheme = model.theme.copyWith(
        chipTheme: ChipThemeData.fromDefaults(
      brightness: value,
      /*primaryColor: model.theme.primaryColor,*/
      secondaryColor: model.theme.primaryColor,
      labelStyle: labelStyle,
    ));
    model.updateTheme(updatedTheme);
  }

  _updateChipTheme(ChipThemeData chipTheme) {
    ThemeData updatedTheme = model.theme.copyWith(chipTheme: chipTheme);
    model.updateTheme(updatedTheme);
  }
}
