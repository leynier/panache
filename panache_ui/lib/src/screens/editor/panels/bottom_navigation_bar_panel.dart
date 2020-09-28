import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

String _themeRef = 'bottomNavigationBarTheme';

///https://api.flutter.dev/flutter/material/ThemeData-class.html
///https://api.flutter.dev/flutter/material/BottomNavigationBarThemeData-class.html
class BottomNavigationBarThemePanel extends StatelessWidget {
  final ThemeModel model;
  TextStyle labelStyle;
  TextStyle dropdownTextStyle;
  BottomNavigationBarThemePanel(this.model, {Key key}) : super(key: key);

  ThemeData get myTheme => model.theme;
  BottomNavigationBarThemeData get currentTheme =>
      myTheme.bottomNavigationBarTheme;

  IconThemeData get selectedIconTheme {
    IconThemeData iconTheme =
        model.theme.bottomNavigationBarTheme.selectedIconTheme;
    if (iconTheme == null) {
      iconTheme = const IconThemeData();
    }
    return iconTheme;
  }

  IconThemeData get unSelectedIconTheme {
    IconThemeData iconTheme =
        model.theme.bottomNavigationBarTheme.unselectedIconTheme;
    if (iconTheme == null) {
      iconTheme = const IconThemeData();
    }
    return iconTheme;
  }

  TextStyle get selectedLabelStyle {
    return myTheme?.bottomNavigationBarTheme?.selectedLabelStyle ??
        createDefaultTextStyle();
  }

  TextStyle get unselectedLabelStyle {
    return myTheme?.bottomNavigationBarTheme?.unselectedLabelStyle ??
        createDefaultTextStyle();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                Text('Text theme', style: labelStyle),
              ],
            ),
          ),
          DropdownButton(
            style: dropdownTextStyle,
            value: currentTheme.type ?? BottomNavigationBarType.fixed,
            items: BottomNavigationBarType.values
                .map(_buildButtonTextThemeSelectorItem)
                .toList(growable: false),
            onChanged: (newButtonTextTheme) => _updateAppBarTheme(
              currentTheme.copyWith(type: newButtonTextTheme),
            ),
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'backgroundColor',
                myTheme.bottomNavigationBarTheme?.backgroundColor ?? Colors.red,
                (Color color) => _updateAppBarTheme(myTheme
                    .bottomNavigationBarTheme
                    .copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SliderPropertyControl(
                myTheme.bottomNavigationBarTheme?.elevation ?? 8,
                (double elevation) => _updateAppBarTheme(myTheme
                    .bottomNavigationBarTheme
                    .copyWith(elevation: elevation)),
                label: 'Elevation',
                max: 20,
                maxWidth: 20,
                vertical: true,
              ),
            ],
          ),
          Divider(
            height: 32,
          ),
          Text('selectedIconTheme', style: appTextTheme.subtitle1),
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
                  model.theme?.primaryIconTheme?.opacity ??
                  0.5,
              (double opacity) => _updateSelectedIconTheme(
                  selectedIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0,
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'selectedItemColor',
              myTheme.bottomNavigationBarTheme?.selectedItemColor ??
                  model.theme.primaryIconTheme?.color,
              (Color color) => _updateAppBarTheme(
                  currentTheme.copyWith(selectedItemColor: color)),
              padding: 4,
            ),
            SwitcherControl(
              checked:
                  myTheme.bottomNavigationBarTheme?.showSelectedLabels ?? false,
              checkedLabel: 'showSelectedLabels',
              direction: Axis.vertical,
              onChange: (bool value) => _updateAppBarTheme(
                  currentTheme.copyWith(showSelectedLabels: value ?? false)),
            ),
          ]),
          const Divider(),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'selectedLabelStyle',
            textStyle: selectedLabelStyle,
            label: 'selectedItem Label Style',
            styleName: 'selectedLabelStyle',
          ),
          Text('UnSelectedIconTheme', style: appTextTheme.subtitle1),
          ColorSelector(
            'Color',
            unSelectedIconTheme?.color ?? model.theme.primaryIconTheme?.color,
            (Color color) => _updateUnSelectedIconTheme(
                selectedIconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                unSelectedIconTheme?.size ??
                    model.theme?.primaryIconTheme?.size ??
                    20,
                (double size) => _updateUnSelectedIconTheme(
                    selectedIconTheme.copyWith(size: size)),
                label: 'Size',
                min: 8,
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
              SliderPropertyControl(
                unSelectedIconTheme?.opacity ??
                    model.theme?.primaryIconTheme?.opacity ??
                    0.5,
                (double opacity) => _updateUnSelectedIconTheme(
                    selectedIconTheme.copyWith(opacity: opacity)),
                label: 'Opacity',
                max: 1,
                vertical: true,
                showDivisions: false,
              ),
            ],
          ),
          getFieldsRow(<Widget>[
            ColorSelector(
              'unSelectedItemColor',
              myTheme.bottomNavigationBarTheme?.unselectedItemColor ??
                  model.theme.primaryIconTheme?.color,
              (Color color) => _updateAppBarTheme(
                  currentTheme.copyWith(unselectedItemColor: color)),
              padding: 4,
            ),
            SwitcherControl(
                checked:
                    myTheme.bottomNavigationBarTheme?.showUnselectedLabels ??
                        false,
                checkedLabel: 'showUnselectedLabels ',
                direction: Axis.vertical,
                onChange: (value) {
                  _updateAppBarTheme(currentTheme.copyWith(
                      showUnselectedLabels: value ?? false));
                }),
          ]),
          const Divider(),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'unselectedLabelStyle',
            textStyle: unselectedLabelStyle,
            label: 'unselectedItem Label Style',
            styleName: 'unselectedLabelStyle',
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

  void _updateMyTheme(ThemeData myTheme) {
    //ThemeData updatedTheme = model.theme.copyWith(appBarTheme: appBarTheme);
    model.updateTheme(myTheme /*updatedTheme*/);
  }

  void _updateAppBarTheme(BottomNavigationBarThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme =
        model.theme.copyWith(bottomNavigationBarTheme: theme);

    model.updateTheme(updatedTheme);
  }

  void _updateSelectedIconTheme(IconThemeData actionsIconTheme) =>
      model.updateTheme(model.theme.copyWith(
          bottomNavigationBarTheme: model.theme.bottomNavigationBarTheme
              .copyWith(selectedIconTheme: actionsIconTheme)));

  void _updateUnSelectedIconTheme(IconThemeData actionsIconTheme) =>
      model.updateTheme(model.theme.copyWith(
          bottomNavigationBarTheme: model.theme.bottomNavigationBarTheme
              .copyWith(unselectedIconTheme: actionsIconTheme)));

  DropdownMenuItem<BottomNavigationBarType> _buildButtonTextThemeSelectorItem(
          BottomNavigationBarType bottomNavigationBarType) =>
      DropdownMenuItem<BottomNavigationBarType>(
        child: Text('$bottomNavigationBarType'.split('.').last),
        value: bottomNavigationBarType,
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<TextStyle>('labelStyle', labelStyle));
    properties.add(
        DiagnosticsProperty<TextStyle>('dropdownTextStyle', dropdownTextStyle));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
    properties.add(DiagnosticsProperty<BottomNavigationBarThemeData>(
        'currentTheme', currentTheme));
    properties.add(DiagnosticsProperty<IconThemeData>(
        'selectedIconTheme', selectedIconTheme));
    properties.add(DiagnosticsProperty<IconThemeData>(
        'unSelectedIconTheme', unSelectedIconTheme));
    properties.add(DiagnosticsProperty<TextStyle>(
        'selectedLabelStyle', selectedLabelStyle));
    properties.add(DiagnosticsProperty<TextStyle>(
        'unselectedLabelStyle', unselectedLabelStyle));
  }
}
