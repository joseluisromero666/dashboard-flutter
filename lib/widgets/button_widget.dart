import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key key,
    @required this.title,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: title,
        child: ButtonWidget(
          text: text,
          onClicked: onClicked,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: Theme.of(context).primaryColor == Colors.green[500]
              ? Colors.grey[500]
              : Theme.of(context).primaryColor == Colors.indigo[500]
                  ? ArgonColors.white
                  : Colors.blueGrey[300],
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).primaryColor == Colors.green[500]
                    ? Colors.grey[200]
                    : Theme.of(context).primaryColor == Colors.indigo[500]
                        ? ArgonColors.black
                        : Colors.blue[900]),
          ),
        ),
        onPressed: onClicked,
      );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      );
}

class ButtonWidgett extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color mColor;

  const ButtonWidgett({
    Key key,
    @required this.text,
    @required this.onClicked,
    @required this.mColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(55),
          primary: this.mColor,
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: ArgonColors.white),
          ),
        ),
        onPressed: onClicked,
      );
}

class ButtonWidgettLogOut extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color mColor;

  const ButtonWidgettLogOut({
    Key key,
    @required this.text,
    @required this.onClicked,
    @required this.mColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(35),
          primary: this.mColor,
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: ArgonColors.white),
          ),
        ),
        onPressed: onClicked,
      );
}
