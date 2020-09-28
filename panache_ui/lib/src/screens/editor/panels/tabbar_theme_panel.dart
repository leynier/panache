import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';

import '../controls/color_selector.dart';
import '../editor_utils.dart';

String _themeRef = 'tabBarTheme';

class TabBarThemePanel extends StatelessWidget {
  final ThemeModel model;

  TabBarTheme get tabTheme => model.theme.tabBarTheme;

  const TabBarThemePanel(this.model, {Key key}) : super(key: key);

  Color get selectedColor =>
      model.theme.tabBarTheme.labelColor ??
      model.theme.primaryTextTheme.bodyText1.color;

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = tabTheme.labelStyle ?? createDefaultTextStyle();
    TextStyle unselectedLabelStyle =
        tabTheme.unselectedLabelStyle ?? createDefaultTextStyle();
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(<Widget>[
            ColorSelector(
              'Label color',
              selectedColor,
              (Color color) =>
                  _updateTabBarTheme(tabTheme.copyWith(labelColor: color)),
              padding: 4,
            ),
            ColorSelector(
              'Unselected label color',
              tabTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2),
              (Color color) => _updateTabBarTheme(
                  tabTheme.copyWith(unselectedLabelColor: color)),
              padding: 4,
            ),
          ]),
          /*
          _TabBarIndicatorControl(
            decoration:
                tabTheme.indicator ?? _indicatorDecorations.first.decoration,
            onDecorationChanged: (value) =>
                _updateTabBarTheme(tabTheme.copyWith(indicator: value)),
          ),*/
          _TabBarIndicatorSizeControl(
            indicatorSize: tabTheme.indicatorSize,
            onSizeModeChanged: (TabBarIndicatorSize value) =>
                _updateTabBarTheme(tabTheme.copyWith(indicatorSize: value)),
          ),
          const Divider(),
          const Text('labelStyle'),
          buildTextStyleControl(
            _themeRef,
            model,
            tabTheme.copyWith,
            key: 'labelStyle',
            textStyle: labelStyle,
            label: 'labelStyle',
            styleName: 'labelStyle',
          ),
          const Divider(),
          const Text('unselectedLabelStyle'),
          buildTextStyleControl(
            _themeRef,
            model,
            tabTheme.copyWith,
            key: 'unselectedLabelStyle',
            textStyle: unselectedLabelStyle,
            label: 'unselectedLabelStyle',
            styleName: 'unselectedLabelStyle',
          ),
        ],
      ),
    );
  }

  void _updateTabBarTheme(TabBarTheme tabTheme) =>
      model.updateTheme(model.theme.copyWith(tabBarTheme: tabTheme));
}

class _TabBarIndicatorSizeControl extends StatelessWidget {
  final ValueChanged<TabBarIndicatorSize> onSizeModeChanged;
  final TabBarIndicatorSize indicatorSize;

  const _TabBarIndicatorSizeControl(
      {Key key, @required this.onSizeModeChanged, @required this.indicatorSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FieldBorder(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Text(
                'Indicator size',
                style: appTextTheme.subtitle2,
              ),
            ),
            Radio(
                value: TabBarIndicatorSize.tab,
                groupValue: indicatorSize ?? TabBarIndicatorSize.tab,
                onChanged: onSizeModeChanged),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Text('Tab'),
            ),
            Radio(
                value: TabBarIndicatorSize.label,
                groupValue: indicatorSize ?? TabBarIndicatorSize.tab,
                onChanged: onSizeModeChanged),
            Text('Label'),
          ],
        ),
      ),
    );
  }
}

class _TabBarIndicatorControl extends StatelessWidget {
  final Decoration decoration;
  final ValueChanged<Decoration> onDecorationChanged;

  const _TabBarIndicatorControl(
      {Key key, this.decoration, this.onDecorationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return FieldBorder(
      child: Row(children: [
        Text('Indicator decoration', style: textTheme.subtitle2),
        DropdownButton(
            items: _indicatorDecorations.map((value) {
              return DropdownMenuItem(
                  child: Text("${value.name}"), value: value.decoration);
            }).toList(growable: false),
            value: decoration,
            onChanged: onDecorationChanged)
      ]),
    );
  }
}

final List<IndicatorDecoration> _indicatorDecorations = [
  IndicatorDecoration('UnderlineTabIndicator', UnderlineTabIndicator()),
  IndicatorDecoration('BoxDecoration', BoxDecoration()),
  IndicatorDecoration(
    'ShapeDecoration',
    ShapeDecoration(
      color: Colors.pink,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(5)),
      ),
    ),
  )
];

class IndicatorDecoration {
  final String name;
  final Decoration decoration;

  const IndicatorDecoration(this.name, this.decoration);
}
