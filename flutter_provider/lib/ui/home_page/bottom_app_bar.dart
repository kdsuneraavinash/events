import 'package:events/logic/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theme_provider/theme_provider.dart';

class HomePageBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _bottomAppBarButtonWidget(
            context: context,
            icon: FontAwesomeIcons.plusSquare,
            label: "Add Event",
            onPressed: () {},
          ),
          _bottomAppBarButtonWidget(
            context: context,
            icon: FontAwesomeIcons.list,
            label: "Fliter",
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          )
        ],
      ),
    );
  }

  Widget _bottomAppBarButtonWidget({
    @required IconData icon,
    @required String label,
    @required BuildContext context,
    VoidCallback onPressed,
  }) {
    Color color = ThemeProvider.optionsOf<ThemeOptions>(context)
        .textOnPrimaryColorTextColor;

    return FlatButton.icon(
      icon: Icon(icon, color: color),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(label, style: TextStyle(color: color)),
      ),
      onPressed: onPressed,
    );
  }
}
