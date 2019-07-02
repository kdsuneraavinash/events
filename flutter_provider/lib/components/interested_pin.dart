import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterestedPin extends StatefulWidget {
  final String selectedText;
  final String unselectedText;
  final VoidCallback onPressed;
  final bool _selected;

  InterestedPin(this._selected,
      {this.selectedText, this.unselectedText, this.onPressed});

  @override
  _InterestedPinState createState() => _InterestedPinState(_selected);
}

class _InterestedPinState extends State<InterestedPin> {
  bool selected;

  _InterestedPinState(this.selected);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(
        selected ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
        color: Colors.white,
        size: 20,
      ),
      label: Text(
        selected ? widget.selectedText : widget.unselectedText,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        setState(() {
          selected = !selected;
        });
        widget.onPressed();
      },
    );
  }
}
