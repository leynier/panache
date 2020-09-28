import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'controls/color_picker/colorpicker_dialog.dart';
//import 'controls/color_menu.dart';

class ColorSwatchControl extends StatelessWidget {
  final Color color;

  final ValueChanged<Color> onSelection;

  String get label {
    Iterable<NamedColor> namedPeer = namedColors().where(
        (NamedColor namedColor) => namedColor.color?.value == color?.value);
    return namedPeer.isNotEmpty
        ? namedPeer.first.name
        : "#${color?.value.toRadixString(16)}";
  }

  const ColorSwatchControl({this.color, this.onSelection, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onSelection != null
          ? () => showColorPicker(
              context: context, onColor: onSelection, currentColor: color)
          : null
      /*openColorMenu(BuildContext context, onSelection: onSelection, color: color)*/,
      child: Container(
        width: kSwatchSize,
        height: kSwatchSize,
        decoration: BoxDecoration(
            color: color ?? Colors.black, border: Border.all(width: 0.5)),
      ));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(
        ObjectFlagProperty<Function(Color)>.has('onSelection', onSelection));
    properties.add(StringProperty('label', label));
  }
}
