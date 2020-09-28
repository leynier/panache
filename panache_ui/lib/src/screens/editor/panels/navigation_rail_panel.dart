import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import 'package:panache_ui/src/screens/editor/panels/panels.dart';

import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'navigationRailTheme';

class NavigationRailThemePanel extends StatelessWidget {
  final ThemeModel model;

  NavigationRailThemeData get currentTheme => model.theme.navigationRailTheme;
  TextTheme get textTheme {
    TextTheme textTheme = model.theme.appBarTheme.textTheme;
    if (textTheme == null) {
      textTheme = model.theme.primaryTextTheme;
    }
    return textTheme;
  }

  IconThemeData get selectedIconTheme {
    IconThemeData selectedIconTheme = currentTheme.selectedIconTheme;
    if (selectedIconTheme == null) {
      selectedIconTheme = IconThemeData(color: model.theme.primaryColor);
    }
    return selectedIconTheme;
  }

  IconThemeData get unselectedIconTheme {
    IconThemeData unselectedIconTheme = currentTheme.unselectedIconTheme;
    if (unselectedIconTheme == null) {
      unselectedIconTheme = IconThemeData(color: model.theme.accentColor);
    }
    return unselectedIconTheme;
  }

  final List<SelectionItem<NavigationRailLabelType>> _labelTypes =
      <SelectionItem<NavigationRailLabelType>>[
    SelectionItem<NavigationRailLabelType>(
        'none    ', NavigationRailLabelType.none),
    SelectionItem<NavigationRailLabelType>(
        'all   ', NavigationRailLabelType.all),
    SelectionItem<NavigationRailLabelType>(
        'selected   ', NavigationRailLabelType.selected),
  ];

  NavigationRailThemePanel(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    TextStyle unselectedLabelTextStyle =
        currentTheme.unselectedLabelTextStyle ?? createDefaultTextStyle();
    TextStyle selectedLabelTextStyle =
        currentTheme.selectedLabelTextStyle ?? createDefaultTextStyle();
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'backgroundColor ',
                currentTheme.backgroundColor ?? model.theme.colorScheme.surface,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SliderPropertyControl(
                currentTheme.elevation ?? 0,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(elevation: value)),
                label: 'Elevation',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                currentTheme.groupAlignment ?? 0,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(groupAlignment: value)),
                label: 'groupAlignment',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
              PanacheDropdown<SelectionItem<NavigationRailLabelType>>(
                label: 'labelType ',
                selection: currentTheme.labelType != null
                    ? _labelTypes.firstWhere(
                        (SelectionItem<NavigationRailLabelType> item) =>
                            item.value == currentTheme.labelType)
                    : _labelTypes.first,
                collection: _labelTypes,
                onValueChanged:
                    (SelectionItem<NavigationRailLabelType> labelType) =>
                        _updateCurrentTheme(
                            currentTheme.copyWith(labelType: labelType.value)),
              ),
            ],
          ),
          const Divider(),
          Text('SelectedIcon theme', style: appTextTheme.subtitle1),
          ColorSelector(
            'Color',
            selectedIconTheme?.color ?? model.theme.primaryIconTheme?.color,
            (Color color) => _updateSelectedIconTheme(
                selectedIconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              selectedIconTheme?.size ??
                  model.theme.primaryIconTheme.size ??
                  20,
              (double size) => _updateSelectedIconTheme(
                  selectedIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
            SliderPropertyControl(
              selectedIconTheme?.opacity ??
                  model.theme.primaryIconTheme.opacity ??
                  0.5,
              (double opacity) => _updateSelectedIconTheme(
                  selectedIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'selectedLabelTextStyle',
            textStyle: selectedLabelTextStyle,
            label: 'selectedLabelTextStyle',
            styleName: 'selectedLabelTextStyle',
          ),
          const Divider(
            height: 32,
          ),
          Text('UnselectedIconTheme', style: appTextTheme.subtitle1),
          ColorSelector(
            'Color',
            unselectedIconTheme?.color ?? model.theme.iconTheme.color,
            (Color color) => _updateunselectedIconTheme(
                unselectedIconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              unselectedIconTheme?.size ?? model.theme.iconTheme.size ?? 20,
              (double size) => _updateunselectedIconTheme(
                  unselectedIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
            SliderPropertyControl(
              unselectedIconTheme?.opacity ??
                  model.theme.iconTheme.opacity ??
                  0.5,
              (double opacity) => _updateunselectedIconTheme(
                  unselectedIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'unselectedLabelTextStyle',
            textStyle: unselectedLabelTextStyle,
            label: 'unselectedLabelTextStyle',
            styleName: 'unselectedLabelTextStyle',
          ),
        ],
      ),
    );
  }

  void _updateCurrentTheme(NavigationRailThemeData theme) {
    ThemeData updatedTheme = model.theme.copyWith(navigationRailTheme: theme);
    model.updateTheme(updatedTheme);
  }

  void _updateunselectedIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(
          navigationRailTheme:
              currentTheme.copyWith(unselectedIconTheme: iconTheme)));

  void _updateSelectedIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(
          navigationRailTheme:
              currentTheme.copyWith(selectedIconTheme: iconTheme)));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextTheme>('textTheme', textTheme));
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
  }
}
