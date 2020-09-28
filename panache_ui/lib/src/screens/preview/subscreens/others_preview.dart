import 'package:flutter/material.dart';

import '../../editor/editor_utils.dart';

class OthersPreview extends StatelessWidget {
  final ThemeData theme;

  const OthersPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: <Widget>[
                    const Text("Card"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        CircleAvatar(
                          child: Icon(Icons.person_pin),
                        ),
                        Text('Circle Avatar')
                      ],
                    ),
                    getFieldsRow(
                      <Widget>[
                        FlatButton.icon(
                          icon: const Icon(Icons.event),
                          label: const Text('Datepicker'),
                          onPressed: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100)),
                        ),
                        FlatButton.icon(
                          icon: const Icon(Icons.access_time),
                          label: const Text('TimePicker'),
                          onPressed: () => showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          ),
                        ),
                      ],
                    ),
                    getFieldsRow(
                      <Widget>[
                        FlatButton.icon(
                          icon: const Icon(Icons.sort),
                          label: const Text('SnackBar'),
                          onPressed: () => _showSnackBar(context),
                        ),
                        Tooltip(
                          message: 'Test Tooltip',
                          child: FlatButton(
                            child: Text('Tooltip'),
                            onPressed: () => print('Button pressed'),
                          ),
                        ),
                      ],
                    ),
                    getFieldsRow(
                      <Widget>[
                        FlatButton.icon(
                          icon: const Icon(Icons.bookmark_border),
                          label: const Text('BottomSheet'),
                          onPressed: () {
                            showBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: Text(
                                        'This is the non-modal bottom sheet. Slide down to dismiss.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                        FittedBox(
                          child: FlatButton.icon(
                            icon: const Icon(Icons.bookmark),
                            label: const Text(
                              'ModalBottomSheet',
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Text(
                                          'This is the modal bottom sheet. Slide down to dismiss.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                    getFieldsRow(
                      <Widget>[
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu(details.globalPosition, context);
                          },
                          child: Container(child: Text("showPopupMenu")),
                        ),
                        FlatButton.icon(
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('Dialog'),
                          onPressed: () => _showDialog(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Text('Progress'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: 0.57,
                ),
              ),
              CircularProgressIndicator(
                value: 0.57,
                backgroundColor: Colors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
            child: Dialog(
              child: Container(
                width: 420,
                height: 420,
                child: Text(
                  'a simple dialog',
                  style: theme.textTheme.headline5,
                ),
              ),
            ),
            data: theme),
      );

  _showSnackBar(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          print('Undo button pressed !');
        },
      ),
    );

    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _showPopupMenu(Offset offset, BuildContext context) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
          child: Text("View"),
        ),
        PopupMenuItem(
          child: Text("Edit"),
        ),
        PopupMenuItem(
          child: Text("Delete"),
        ),
      ],
      elevation: 8.0,
    );
  }
}
