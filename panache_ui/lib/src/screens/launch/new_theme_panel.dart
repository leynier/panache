import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../../screens/editor/controls/brightness_control.dart';
import '../../screens/editor/controls/color_selector.dart';

class NewThemePanel extends StatelessWidget {
  final ColorSwatch newThemePrimary;

  final Brightness initialBrightness;

  final ValueChanged<ColorSwatch> onSwatchSelection;

  final ValueChanged<Brightness> onBrightnessSelection;
  final VoidCallback onNewTheme;

  final VoidCallback onImportTheme;

  final Orientation orientation;

  bool get isDark => initialBrightness == Brightness.dark;

  const NewThemePanel({
    @required this.newThemePrimary,
    @required this.initialBrightness,
    @required this.onSwatchSelection,
    @required this.onBrightnessSelection,
    @required this.onNewTheme,
    @required this.onImportTheme,
    @required this.orientation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final inPortrait = orientation == Orientation.portrait;
    final isLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;
    final isMobileInLandscape = !inPortrait && !isLargeLayout;

    final newThemeLabel = Padding(
      padding: EdgeInsets.only(
          bottom: isMobileInLandscape ? 0 : 16,
          right: isMobileInLandscape ? 16 : 0),
      child: Text('New theme', style: textTheme.headline6),
    );
    Padding btCreate = Padding(
      padding: EdgeInsets.only(top: isMobileInLandscape ? 2 : 16),
      child: RaisedButton.icon(
        shape: StadiumBorder(),
        color: newThemePrimary,
        icon: Icon(Icons.color_lens, color: newThemePrimary[100]),
        label: const Text('Create', style: TextStyle(color: Colors.white)),
        onPressed: onNewTheme,
      ),
    );

    Padding btImportTheme = Padding(
      padding: EdgeInsets.only(top: isMobileInLandscape ? 2 : 16),
      child: RaisedButton.icon(
        shape: StadiumBorder(),
        color: newThemePrimary,
        icon: Icon(Icons.file_upload, color: newThemePrimary[100]),
        label:
            const Text('Import theme', style: TextStyle(color: Colors.white)),
        onPressed: onImportTheme,
      ),
    );
    return Container(
      padding: EdgeInsets.all(isMobileInLandscape ? 6 : 16),
      color: Colors.white54,
      child: Column(
        children: <Widget>[
          isLargeLayout || inPortrait ? newThemeLabel : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                  child: ColorSelector(
                      'Primary swatch',
                      newThemePrimary,
                      (Color color) =>
                          onSwatchSelection(swatchFor(color: color)))),
              SizedBox(width: 10),
              BrightnessSelector(
                isDark: isDark,
                label: 'Brightness',
                onBrightnessChanged: onBrightnessSelection,
              ),
            ]
              ..insert(
                  0, !inPortrait && !isLargeLayout ? newThemeLabel : SizedBox())
              ..add(!inPortrait && !isLargeLayout ? btCreate : SizedBox())
              ..add(!inPortrait && !isLargeLayout ? btImportTheme : SizedBox()),
          ),
          isLargeLayout || inPortrait ? btCreate : SizedBox(),
          isLargeLayout || inPortrait ? btImportTheme : SizedBox(),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('newThemePrimary', newThemePrimary));
    properties
        .add(EnumProperty<Brightness>('initialBrightness', initialBrightness));
    properties.add(ObjectFlagProperty<Function(ColorSwatch<dynamic>)>.has(
        'onSwatchSelection', onSwatchSelection));
  }
}
