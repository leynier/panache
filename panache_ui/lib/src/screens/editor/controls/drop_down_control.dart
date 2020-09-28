import 'package:flutter/material.dart';
import 'package:panache_ui/src/screens/editor/controls/control_container.dart';

class SelectionItem<T> {
  final String label;
  final T value;

  const SelectionItem(this.label, this.value);
}

class PanacheDropdown<D extends SelectionItem> extends StatelessWidget {
  final List<D> collection;

  final D selection;

  final String label;
  final ValueChanged<D> onValueChanged;

  const PanacheDropdown(
      {Key key,
      @required this.collection,
      @required this.onValueChanged,
      @required this.selection,
      this.label: ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ControlContainerBorder(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 8),
          child: Text(
            label,
            style: textTheme.subtitle2,
          ),
        ),
        DropdownButton(
            items: buildItems(
              style: textTheme.bodyText1,
            ),
            isDense: true,
            value: selection,
            hint: Text(
              label,
              style: textTheme.bodyText1,
            ),
            onChanged: onValueChanged),
      ],
    ));
  }

  List<DropdownMenuItem<D>> buildItems({TextStyle style}) => collection
      .map<DropdownMenuItem<D>>((item) => toDropdownMenuItem(item, style))
      .toList(growable: false);

  DropdownMenuItem<D> toDropdownMenuItem(D item, TextStyle style) =>
      DropdownMenuItem(
        child: Text(item.label, style: style),
        value: item,
      );
}
