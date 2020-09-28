import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../../../help/help.dart';
import '../color_swatch.dart';
import 'control_container.dart';
import 'help_button.dart';

class ColorSelector extends StatelessWidget {
  final String label;
  final Color value;
  final ValueChanged<Color> onSelection;
  final double padding;
  final bool enabled;

  final double maxLabelWidth;

  final HelpData help;

  const ColorSelector(this.label, this.value, this.onSelection,
      {this.padding = 8,
      this.maxLabelWidth = 100,
      this.help,
      this.enabled = true,
      Key key})
      : super(key: key);

  String get colorLabel {
    Iterable<NamedColor> namedPeer = namedColors().where(
        (NamedColor namedColor) => namedColor.color?.value == value?.value);
    return namedPeer.isNotEmpty
        ? namedPeer.first.name
        : value != null
            ? "#${value.value.toRadixString(16)}"
            : "#${Colors.black.value.toRadixString(16)}";
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ControlContainerBorder(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                      text: '$label\n',
                      style: Theme.of(context).textTheme.subtitle2,
                      children: <InlineSpan>[
                        TextSpan(
                            text: colorLabel,
                            style: textTheme.overline.copyWith(height: 1.5)
                            /*kDarkTextStyle.copyWith(height: 2)*/)
                      ]),
                ),
                if (help != null) HelpButton(help: help)
              ],
            ),
          ),
          ColorSwatchControl(
              color: value, onSelection: enabled ? onSelection : null),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(ColorProperty('value', value));
    properties.add(
        ObjectFlagProperty<Function(Color)>.has('onSelection', onSelection));
    properties.add(StringProperty('colorLabel', colorLabel));
    properties.add(DoubleProperty('padding', padding));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled));
    properties.add(DoubleProperty('maxLabelWidth', maxLabelWidth));
    properties.add(DiagnosticsProperty<HelpData>('help', help));
  }
}
