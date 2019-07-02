import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:event_app/redux_store/actions.dart';
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/state/flagged.dart';
import 'package:event_app/screens/event_details.dart';
import 'package:event_app/custom_widgets/transition_maker.dart';

class EventFlaggedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<EventState>(
      builder: (context, eventStore) =>
          _buildEventFlaggedItemButton(context, eventStore),
    );
  }

  /// Flagged Item
  Widget _buildEventFlaggedItemButton(
      BuildContext context, Store<EventState> eventStore) {
    return ExpansionTile(
      key: Key(this.flaggedEvent.eventID),
      title: Text(
        eventStore.state.eventList[this.flaggedEvent.eventID].eventName,
      ),
      trailing: this.flaggedEvent.alarmStatus
          ? _buildAlarmDispatchButton(
              icon: Icons.alarm_on,
              eventStore: eventStore,
            )
          : _buildAlarmDispatchButton(
              icon: Icons.alarm_off,
              eventStore: eventStore,
              color: Colors.grey),
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
              eventStore.state.eventList[this.flaggedEvent.eventID].organizer),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          child: Text(
            'Starts at ${eventStore.state.eventList[this.flaggedEvent.eventID].startTimeString}',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildActionButtonButton(
                icon: Icons.remove_red_eye,
                label: "View",
                onPressed: () => _handleViewPressed(context, eventStore),
                context: context),
            _buildActionButtonButton(
                icon: Icons.delete_outline,
                label: "Unpin",
                onPressed: () => _handleUnpinPressed(context, eventStore),
                context: context),
          ],
        ),
      ],
    );
  }

  /// Alarm ON/OFF Button
  Widget _buildAlarmDispatchButton(
      {IconData icon, Store<EventState> eventStore, Color color}) {
    return IconButton(
      icon: CircleAvatar(
        child: Icon(icon),
        backgroundColor: color,
      ),
      onPressed: () => eventStore.dispatch(ChangeAlarmState(
          this.flaggedEvent.eventID,
          !this.flaggedEvent.alarmStatus,
          DateTime.now())),
    );
  }

  /// Buttons in Flagged Card
  Widget _buildActionButtonButton(
      {IconData icon,
      String label,
      VoidCallback onPressed,
      BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: OutlineButton.icon(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }

  /// Will show EventImageView
  void _handleViewPressed(BuildContext context, Store<EventState> eventStore) {
    TransitionMaker
        .slideTransition(
          destinationPageCall: () => EventDetails(
              eventStore.state.eventList[this.flaggedEvent.eventID]),
        )
        .start(context);
  }

  /// Will unpin Event ans show a snackbar
  void _handleUnpinPressed(BuildContext context, Store<EventState> eventStore) {
    ThemeData currentTheme = Theme.of(context);
    eventStore.dispatch(
        RemoveFromFlaggedList(this.flaggedEvent.eventID, DateTime.now()));
    Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${eventStore.state.eventList[this.flaggedEvent.eventID].eventName} Unpinned",
              style: TextStyle(color: currentTheme.scaffoldBackgroundColor),
            ),
            backgroundColor: currentTheme.accentColor,
          ),
        );
  }

  EventFlaggedCard(this.flaggedEvent);

  final FlaggedEvent flaggedEvent;
}
