import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

double _kGridSpacing = 6;

class ColorSwatchesWidget extends StatelessWidget {
  final Color color;

  const ColorSwatchesWidget(this.color, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = newColorSwatch(color);

    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        final itemWidth = (constraints.maxWidth - _kGridSpacing) / 2;
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Swatches',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: getContrastColor(getSwatchShade(color, 700))),
              ),
            ),
            Wrap(
              spacing: _kGridSpacing,
              runSpacing: _kGridSpacing,
              children: getMaterialColorShades(c).map<Widget>((c) {
                return Container(
                  alignment: Alignment.center,
                  color: color,
                  width: itemWidth,
                  height: 60,
                  child: Text(colorToHex32(c),
                      style: TextStyle(
                        fontSize: 14,
                        color: getContrastColor(c),
                      )),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
