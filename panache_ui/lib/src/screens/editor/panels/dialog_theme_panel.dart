import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/color_selector.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import 'package:panache_ui/src/screens/editor/editor_utils.dart';

import '../controls/shape_form_control.dart';

final showIndicatorOptions = [
  ShowValueIndicator.always,
  ShowValueIndicator.never,
  ShowValueIndicator.onlyForContinuous,
  ShowValueIndicator.onlyForDiscrete,
];

String _themeRef = "dialogTheme";

class DialogThemePanel extends StatelessWidget {
  final ThemeModel model;

  DialogTheme get dialogTheme => model.theme.dialogTheme;

  const DialogThemePanel(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle contentTextStyle =
        dialogTheme.contentTextStyle ?? createDefaultTextStyle();
    TextStyle titleTextStyle =
        dialogTheme.titleTextStyle ?? createDefaultTextStyle();
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ShapeFormControl(
              shape: dialogTheme.shape,
              onShapeChanged: (ShapeBorder shape) =>
                  _updateDialogTheme(DialogTheme(shape: shape)),
            ),
          ),
          getFieldsRow(<Widget>[
            ColorSelector(
              'backgroundColor',
              dialogTheme.backgroundColor ?? model.theme.cardColor,
              (Color color) => _updateDialogTheme(
                  dialogTheme.copyWith(backgroundColor: color)),
              padding: 2,
            ),
            SliderPropertyControl(
              dialogTheme.elevation ?? 24,
              (double elevation) => _updateDialogTheme(
                  dialogTheme.copyWith(elevation: elevation)),
              label: 'Elevation',
              max: 50,
              maxWidth: 20,
              vertical: true,
            ),
          ]),
          const Divider(
            height: 32,
          ),
          const Text('contentTextStyle'),
          buildTextStyleControl(
            _themeRef,
            model,
            dialogTheme.copyWith,
            key: 'contentTextStyle',
            textStyle: contentTextStyle,
            label: 'contentTextStyle',
            styleName: 'contentTextStyle',
          ),
          const Divider(
            height: 32,
          ),
          const Text('titleTextStyle'),
          buildTextStyleControl(
            _themeRef,
            model,
            dialogTheme.copyWith,
            key: 'titleTextStyle',
            textStyle: titleTextStyle,
            label: 'titleTextStyle',
            styleName: 'titleTextStyle',
          ),
        ],
      ),
    );
  }

  void _updateDialogTheme(DialogTheme dialogTheme) =>
      model.updateTheme(model.theme.copyWith(dialogTheme: dialogTheme));
}
