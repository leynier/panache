import 'package:flutter/material.dart';

class TypographyPreview extends StatelessWidget {
  final ThemeData theme;

  //TextTheme  textTheme textTheme;
  final TypographyPreviewModes typoPreviewMode;

  const TypographyPreview(
      {Key key, @required this.theme, @required this.typoPreviewMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme;
    Color bgColor;

    switch (typoPreviewMode) {
      case TypographyPreviewModes.accent:
        {
          textTheme = theme.accentTextTheme;
          bgColor = theme.accentColor;
          break;
        }
      case TypographyPreviewModes.primary:
        {
          textTheme = theme.primaryTextTheme;
          bgColor = theme.primaryColor;
          break;
        }
      case TypographyPreviewModes.classic:
      default:
        {
          textTheme = theme.textTheme;
          bgColor = theme.chipTheme.backgroundColor;
          break;
        }
    }
    return Card(
      color:
          /*brightness == Brightness.dark
          ? Colors.grey.shade700
          : Colors.grey.shade100*/
          bgColor,
      //padding: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text(
              'Headline 1',
              style: textTheme.headline1,
            ),
            Text(
              'Headline 2',
              style: textTheme.headline2,
            ),
            Text(
              'Headline 3',
              style: textTheme.headline3,
            ),
            Text(
              'Headline 4',
              style: textTheme.headline4,
            ),
            Text(
              'Headline 5',
              style: textTheme.headline5,
            ),
            Text(
              'Headline 6',
              style: textTheme.headline6,
            ),
            Text(
              'Subtitle 1\nThe quick brown fox jumps over the lazy dog\n',
              style: textTheme.subtitle1,
            ),
            Text(
              'Subtitle 2\nThe quick brown fox jumps over the lazy dog\n',
              style: textTheme.subtitle2,
            ),
            Text(
              'Body Text 1\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\n',
              style: textTheme.bodyText1,
            ),
            Text(
              'Body Text 2\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\n',
              style: textTheme.bodyText2,
            ),
            FlatButton(
              child: Text(
                'Button',
                style: textTheme.button,
              ),
              onPressed: () {},
            ),
            Text(
              'Caption\nThe quick brown fox jumps over the lazy dog\n',
              style: textTheme.caption,
            ),
            Text(
              'Overline\nThe quick brown fox jumps over the lazy dog\n',
              style: textTheme.overline,
            ),
          ],
        ),
      ),
    );
  }
}

enum TypographyPreviewModes {
  accent,
  primary,
  classic,
}
