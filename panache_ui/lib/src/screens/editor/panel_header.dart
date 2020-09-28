import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpanderHeader extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final bool dense;

  ExpanderHeader(
      {@required this.color,
      @required this.label,
      @required this.icon,
      this.dense,
      Key key})
      : super(key: key) {
    print('Label... $label $dense');
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          Text(
            label,
            style: dense ? textTheme.subtitle1 : textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
