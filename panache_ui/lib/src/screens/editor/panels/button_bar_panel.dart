import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'buttonBarTheme';

class ButtonBarThemePanel extends StatelessWidget {
  final ThemeModel model;
  ButtonBarThemePanel(this.model, {Key key}) : super(key: key);
  ButtonBarThemeData get currentTheme => myTheme.buttonBarTheme;
  ThemeData get myTheme => model.theme;

  final List<SelectionItem<MainAxisAlignment>> _mainAxisAlignments =
      <SelectionItem<MainAxisAlignment>>[
    SelectionItem<MainAxisAlignment>('center ', MainAxisAlignment.center),
    SelectionItem<MainAxisAlignment>('end', MainAxisAlignment.end),
    SelectionItem<MainAxisAlignment>(
        'spaceAround ', MainAxisAlignment.spaceAround),
    SelectionItem<MainAxisAlignment>(
        'spaceEvenly  ', MainAxisAlignment.spaceEvenly),
    SelectionItem<MainAxisAlignment>('start  ', MainAxisAlignment.start),
  ];

  final List<SelectionItem<ButtonTextTheme>> _buttonTextThemes =
      <SelectionItem<ButtonTextTheme>>[
    SelectionItem<ButtonTextTheme>('accent  ', ButtonTextTheme.accent),
    SelectionItem<ButtonTextTheme>('normal ', ButtonTextTheme.normal),
    SelectionItem<ButtonTextTheme>('primary  ', ButtonTextTheme.primary),
  ];

  final List<SelectionItem<ButtonBarLayoutBehavior>> _layoutBehaviors =
      <SelectionItem<ButtonBarLayoutBehavior>>[
    SelectionItem<ButtonBarLayoutBehavior>(
        'constrained   ', ButtonBarLayoutBehavior.constrained),
    SelectionItem<ButtonBarLayoutBehavior>(
        'padded  ', ButtonBarLayoutBehavior.padded),
  ];

  final List<SelectionItem<MainAxisSize>> _mainAxisSizes =
      <SelectionItem<MainAxisSize>>[
    SelectionItem<MainAxisSize>('max    ', MainAxisSize.max),
    SelectionItem<MainAxisSize>('min   ', MainAxisSize.min),
  ];

  final List<SelectionItem<VerticalDirection>> _overflowDirections =
      <SelectionItem<VerticalDirection>>[
    SelectionItem<VerticalDirection>('down     ', VerticalDirection.down),
    SelectionItem<VerticalDirection>('up    ', VerticalDirection.up),
  ];

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
              PanacheDropdown<SelectionItem<MainAxisAlignment>>(
                label: 'alignment',
                selection: currentTheme.alignment != null
                    ? _mainAxisAlignments.firstWhere(
                        (SelectionItem<MainAxisAlignment> item) =>
                            item.value == currentTheme.alignment)
                    : _mainAxisAlignments.first,
                collection: _mainAxisAlignments,
                onValueChanged: (SelectionItem<MainAxisAlignment> alignment) =>
                    _updateCurrentTheme(
                        currentTheme.copyWith(alignment: alignment.value)),
              ),
              SwitcherControl(
                checked: currentTheme.buttonAlignedDropdown ?? false,
                checkedLabel: 'buttonAlignedDropdown',
                direction: Axis.vertical,
                onChange: (bool value) => _updateCurrentTheme(
                    currentTheme.copyWith(buttonAlignedDropdown: value)),
              ),
            ],
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              currentTheme.buttonHeight ?? 36,
              (double value) => _updateCurrentTheme(
                  currentTheme.copyWith(buttonHeight: value)),
              label: 'buttonHeight',
              min: 8,
              max: 256,
              maxWidth: 140,
              vertical: true,
            ),
            SliderPropertyControl(
              currentTheme.buttonMinWidth ?? 64,
              (double value) => _updateCurrentTheme(
                  currentTheme.copyWith(buttonMinWidth: value)),
              label: 'buttonMinWidth',
              max: 256,
              maxWidth: 140,
              vertical: true,
            ),
          ]),
          getFieldsRow(
            <Widget>[
              PanacheDropdown<SelectionItem<ButtonTextTheme>>(
                label: 'ButtonTextTheme ',
                selection: currentTheme.buttonTextTheme != null
                    ? _buttonTextThemes.firstWhere(
                        (SelectionItem<ButtonTextTheme> item) =>
                            item.value == currentTheme.buttonTextTheme)
                    : _buttonTextThemes.first,
                collection: _buttonTextThemes,
                onValueChanged:
                    (SelectionItem<ButtonTextTheme> buttonTextTheme) =>
                        _updateCurrentTheme(currentTheme.copyWith(
                            buttonTextTheme: buttonTextTheme.value)),
              ),
              PanacheDropdown<SelectionItem<ButtonBarLayoutBehavior>>(
                label: 'layoutBehavior ',
                selection: currentTheme.layoutBehavior != null
                    ? _layoutBehaviors.firstWhere(
                        (SelectionItem<ButtonBarLayoutBehavior> item) =>
                            item.value == currentTheme.layoutBehavior)
                    : _layoutBehaviors.first,
                collection: _layoutBehaviors,
                onValueChanged:
                    (SelectionItem<ButtonBarLayoutBehavior> layoutBehavior) =>
                        _updateCurrentTheme(currentTheme.copyWith(
                            layoutBehavior: layoutBehavior.value)),
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              PanacheDropdown<SelectionItem<MainAxisSize>>(
                label: 'mainAxisSize  ',
                selection: currentTheme.mainAxisSize != null
                    ? _mainAxisSizes.firstWhere(
                        (SelectionItem<MainAxisSize> item) =>
                            item.value == currentTheme.mainAxisSize)
                    : _mainAxisSizes.first,
                collection: _mainAxisSizes,
                onValueChanged: (SelectionItem<MainAxisSize> mainAxisSize) =>
                    _updateCurrentTheme(currentTheme.copyWith(
                        mainAxisSize: mainAxisSize.value)),
              ),
              PanacheDropdown<SelectionItem<VerticalDirection>>(
                label: 'overflowDirection  ',
                selection: currentTheme.overflowDirection != null
                    ? _overflowDirections.firstWhere(
                        (SelectionItem<VerticalDirection> item) =>
                            item.value == currentTheme.overflowDirection)
                    : _overflowDirections.first,
                collection: _overflowDirections,
                onValueChanged:
                    (SelectionItem<VerticalDirection> overflowDirection) =>
                        _updateCurrentTheme(currentTheme.copyWith(
                            overflowDirection: overflowDirection.value)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateCurrentTheme(ButtonBarThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(buttonBarTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
  }
}
