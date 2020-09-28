import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class ButtonPreview extends StatelessWidget {
  final ThemeData theme;

  const ButtonPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
            'RaisedButton',
            style: theme.textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Wrap(
              spacing: 8,
              children: [
                RaisedButton(
                  onPressed: () => Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Snack bar'))),
                  child: const Text("A button"),
                ),
                RaisedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box),
                  label: const Text('RaisedButton.icon'),
                ),
                const RaisedButton(onPressed: null, child: Text("Disabled")),
                RaisedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.add_box),
                  label: const Text('Disabled with icon'),
                ),
              ],
            ),
          ),
          const Divider(),
          const Text('OutlineButton'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                OutlineButton(onPressed: () {}, child: const Text("A button")),
                OutlineButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box),
                  label: const Text('OutlineButton.icon'),
                ),
                const OutlineButton(onPressed: null, child: Text("Disabled")),
                OutlineButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box),
                  label: const Text('Disabled with icon icon'),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Text(
                  'IconButton',
                  style: theme.textTheme.subtitle1,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {},
              ),
              Text('Enabled', style: theme.textTheme.caption),
              const IconButton(icon: Icon(Icons.style), onPressed: null),
              Text(
                'Disabled',
                style: theme.textTheme.caption,
              ),
            ],
          ),
          const Divider(),
          Row(
            children: <Widget>[
              const Expanded(
                child: Text('Dropdown'),
              ),
              DropdownButton(
                  items: ['Paris', 'Moscou', 'Amsterdam']
                      .map((item) => DropdownMenuItem(child: Text(item)))
                      .toList(growable: false),
                  onChanged: (value) => print('dropdown value $value')),
            ],
          ),
          const Divider(),
          Text('FlatButton', style: theme.textTheme.subtitle1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Wrap(
              children: [
                FlatButton(onPressed: () {}, child: const Text("Enabled")),
                const FlatButton(onPressed: null, child: Text('Disabled')),
                FlatButton.icon(
                  icon: const Icon(Icons.restore_from_trash),
                  onPressed: () {},
                  label: const Text('FlatButton.icon'),
                ),
                FlatButton.icon(
                  icon: const Icon(Icons.restore_from_trash),
                  onPressed: null,
                  label: const Text('Disabled.icon'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetPreview1 extends StatelessWidget {
  final ThemeData theme;

  const WidgetPreview1({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    TextStyle bodyStyle = textTheme.bodyText1.copyWith(fontSize: 12);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: theme.primaryColorDark,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
                'Active color : ThemeData.unselectedWidgetColor\n'
                'Active selected color : ThemeData.toggleableActiveColor\n'
                'Disabled color : ThemeData.disabledColor',
                style: theme.primaryTextTheme.bodyText1.copyWith(
                    height: 1.4,
                    color: getContrastColor(theme.primaryColorDark))),
          ),
          const Divider(),
          Text('Checkbox', style: textTheme.subtitle2),
          Column(
            children: [
              Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: (v) {}),
                  Text('Checkbox', style: bodyStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: true, onChanged: (v) {}),
                  Text('Selected Checkbox', style: bodyStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  const Checkbox(value: false, onChanged: null),
                  Text('Disabled Checkbox', style: bodyStyle)
                ],
              ),
              Row(
                children: <Widget>[
                  const Checkbox(value: true, onChanged: null),
                  Text('Selected Disabled Checkbox', style: bodyStyle)
                ],
              ),
            ],
          ),
          const Divider(),
          Text('Radio buttons', style: textTheme.subtitle2),
          Column(
            children: [
              Row(children: [
                Radio(value: false, onChanged: (v) {}, groupValue: null),
                Text('RadioButton', style: bodyStyle)
              ]),
              Row(children: [
                Radio(value: false, groupValue: null, onChanged: null),
                Text('RadioButton - disabled', style: bodyStyle)
              ]),
              Row(children: [
                Radio(value: true, onChanged: (v) {}, groupValue: true),
                Text('RadioButton - selected', style: bodyStyle)
              ]),
            ],
          ),
          const Divider(),
          Text('Switchs', style: textTheme.subtitle2),
          Column(
            children: [
              Row(children: [
                Switch(value: false, onChanged: (v) {}),
                Text('Switch', style: bodyStyle)
              ]),
              Row(children: [
                Switch(value: true, onChanged: (v) {}),
                Text('selected', style: bodyStyle)
              ]),
              Row(children: [
                const Switch(value: false, onChanged: null),
                Text('disabled', style: bodyStyle)
              ]),
              Row(children: [
                const Switch(value: true, onChanged: null),
                Text('disabled selected', style: bodyStyle)
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
