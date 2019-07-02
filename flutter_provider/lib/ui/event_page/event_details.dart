import 'package:events/logic/theme.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class EventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildEventContents(context),
    );
  }

  List<Widget> _buildEventContents(BuildContext context) {
    EventView eventView = Provider.of<EventView>(context);

    return [
      _listTileWidget(
        context: context,
        title: eventView.name,
        subtitle: "Event Name",
        icon: FontAwesomeIcons.font,
      ),
      _listTileWidget(
        context: context,
        title: eventView.organizer,
        subtitle: "Organizers",
        icon: FontAwesomeIcons.users,
      ),
      _listTileWidget(
        context: context,
        title: eventView.venue,
        subtitle: "Venue",
        icon: FontAwesomeIcons.mapMarked,
      ),
      _listTileWidget(
        context: context,
        title: "Starts on ${eventView.startDate}",
        subtitle: "Start Date",
        icon: FontAwesomeIcons.calendar,
      ),
      _listTileWidget(
        context: context,
        title: "Ends on ${eventView.endDate}",
        subtitle: "End Date",
        icon: FontAwesomeIcons.calendar,
      ),
      _listTileWidget(
        context: context,
        title: eventView.isAllDay
            ? "This is an All Day Event"
            : "From ${eventView.startTime} to ${eventView.endTime}",
        subtitle: "Time Duration",
        icon: FontAwesomeIcons.clock,
      ),
    ];
  }

  Widget _listTileWidget(
      {BuildContext context, String title, String subtitle, IconData icon}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon,
          color: ThemeProvider.optionsOf<ThemeOptions>(context).iconColor),
    );
  }
}
