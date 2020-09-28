import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/color_scheme_control.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';

import '../../../help/help.dart';
import '../controls/color_selector.dart';
import '../controls/control_container.dart';
import '../controls/help_button.dart';
import '../controls/shape_form_control.dart';
import '../controls/slider_control.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

class ButtonThemePanel extends StatelessWidget {
  final ThemeModel model;

  ButtonThemeData get buttonTheme => model.theme.buttonTheme;

  ButtonThemePanel(this.model, {Key key}) : super(key: key);

  final List<SelectionItem<ButtonBarLayoutBehavior>> _layoutBehaviors =
      <SelectionItem<ButtonBarLayoutBehavior>>[
    SelectionItem<ButtonBarLayoutBehavior>(
        'constrained   ', ButtonBarLayoutBehavior.constrained),
    SelectionItem<ButtonBarLayoutBehavior>(
        'padded  ', ButtonBarLayoutBehavior.padded),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    final labelStyle = appTextTheme.subtitle2;
    final dropdownTextStyle = appTextTheme.bodyText1;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade200,
      child: Column(
        children: <Widget>[
          getFieldsRow(<Widget>[
            ColorSelector(
              'Raised button fill color',
              buttonTheme.getFillColor(enabledRaisedButton),
              /* TODO update theme.buttonColor ? */
              (Color color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(buttonColor: color)),
              padding: 2,
              help: buttonColorHelp,
            ),
            ColorSelector(
              'Raised button disabled color',
              buttonTheme.getDisabledFillColor(disabledRaisedButton),
              (Color color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(disabledColor: color)),
              padding: 2,
              help: disabledColorHelp,
            ),
          ]),
          getFieldsRow(<Widget>[
            /* longpress / pressed color */
            ColorSelector(
              'Highlight color',
              buttonTheme.getHighlightColor(enabledRaisedButton),
              (Color color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(highlightColor: color)),
              padding: 2,
              help: highlightColorHelp,
            ),
            /* tap ink color */
            ColorSelector(
              'Splash color',
              buttonTheme.getSplashColor(enabledRaisedButton),
              (Color color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(splashColor: color)),
              padding: 2,
              help: splashColorHelp,
            ),
          ]),
          getFieldsRow(<Widget>[
            /* focus color */
            ColorSelector(
              'Focus color',
              buttonTheme.getFocusColor(enabledRaisedButton),
              (Color color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(focusColor: color)),
              padding: 2,
              help: focusColorHelp,
            ),
            /* pointer on */
            ColorSelector(
              'Hover color',
              buttonTheme.getHoverColor(enabledRaisedButton),
              (Color color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(hoverColor: color)),
              padding: 2,
              help: hoverColorHelp,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _buildButtonTextThemeSelector(
              buttonTheme.textTheme,
              labelStyle: labelStyle,
              dropdownTextStyle: dropdownTextStyle,
              context: context,
            ),
            ShapeFormControl(
              onShapeChanged: (ShapeBorder shape) =>
                  _onButtonThemeChanged(buttonTheme.copyWith(shape: shape)),
              shape: buttonTheme.shape,
              labelStyle: labelStyle,
              direction: Axis.vertical,
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SliderPropertyControl(
                    buttonTheme.padding.horizontal,
                    (padding) => _onButtonThemeChanged(buttonTheme.copyWith(
                        padding: EdgeInsets.symmetric(horizontal: padding))),
                    label: 'Horizontal padding',
                    max: 64,
                    vertical: true,
                  ),
                ),
                SwitcherControl(
                  label: 'Align dropdown',
                  checked: buttonTheme.alignedDropdown,
                  direction: Axis.vertical,
                  onChange: (aligned) => _onButtonThemeChanged(
                      buttonTheme.copyWith(alignedDropdown: aligned)),
                ),
              ],
            ),
          ),
          _buildButtonSizeControl(buttonTheme),
          getFieldsRow(
            <Widget>[
              PanacheDropdown<SelectionItem<ButtonBarLayoutBehavior>>(
                label: 'ButtonTextTheme ',
                selection: buttonTheme.layoutBehavior != null
                    ? _layoutBehaviors.firstWhere(
                        (SelectionItem<ButtonBarLayoutBehavior> item) =>
                            item.value == buttonTheme.layoutBehavior)
                    : _layoutBehaviors.first,
                collection: _layoutBehaviors,
                onValueChanged:
                    (SelectionItem<ButtonBarLayoutBehavior> layoutBehavior) =>
                        _onButtonThemeChanged(buttonTheme.copyWith(
                            layoutBehavior: layoutBehavior.value)),
              ),
            ],
          ),
          ColorSchemeControl(
            scheme: buttonTheme.colorScheme,
            onSchemeChanged: (ColorScheme scheme) => _onButtonThemeChanged(
                buttonTheme.copyWith(colorScheme: scheme)),
          )
        ],
      ),
    );
  }

  Widget _buildButtonSizeControl(ButtonThemeData theme) {
    final minWidth = theme.minWidth;
    final height = theme.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: getFieldsRow(<Widget>[
        SliderPropertyControl(
          minWidth,
          (width) =>
              _onButtonThemeChanged(buttonTheme.copyWith(minWidth: width)),
          label: 'Min width',
          min: 48,
          max: 256,
          vertical: true,
        ),
        SliderPropertyControl(
            height,
            (height) =>
                _onButtonThemeChanged(buttonTheme.copyWith(height: height)),
            label: 'Height',
            min: 24,
            max: 128,
            maxWidth: 200,
            vertical: true),
      ]),
    );
  }

  Widget _buildButtonTextThemeSelector(
    ButtonTextTheme buttonTextTheme, {
    TextStyle labelStyle,
    TextStyle dropdownTextStyle,
    BuildContext context,
  }) {
    return Expanded(
      child: ControlContainerBorder(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  Text('Text theme', style: labelStyle),
                  HelpButton(help: textThemeHelp)
                ],
              ),
            ),
            DropdownButton(
                style: dropdownTextStyle,
                value: buttonTextTheme,
                items: ButtonTextTheme.values
                    .map(_buildButtonTextThemeSelectorItem)
                    .toList(growable: false),
                onChanged: (newButtonTextTheme) => _onButtonThemeChanged(
                    buttonTheme.copyWith(textTheme: newButtonTextTheme))),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<ButtonTextTheme> _buildButtonTextThemeSelectorItem(
          ButtonTextTheme buttonTextTheme) =>
      DropdownMenuItem<ButtonTextTheme>(
        child: Text('$buttonTextTheme'.split('.').last),
        value: buttonTextTheme,
      );

  void _onButtonThemeChanged(ButtonThemeData value) {
    model.updateTheme(
      model.theme.copyWith(buttonTheme: value),
    );
  }
}
