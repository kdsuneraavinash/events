import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:event_app/redux_store/actions.dart' as Actions;
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/state/event.dart';
import 'package:event_app/state/flagged.dart';
import 'package:event_app/custom_widgets/network_image.dart';
import 'package:event_app/custom_widgets/transition_maker.dart';
import 'package:event_app/screens/event_details.dart';

/// Individual Card.
/// Displays a Banner, Event Title and Organizers, and Time and Date.
/// When clicked on Image, shows a Image Banner Window of Pagination of Images.
/// Image will act as a Hero.
/// When clicked on Time and Date, shows a calendar showing the date.
/// User can add this event straight to Google Calendars from here.
/// TODO: Implement Google Calendar event adding
class EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<EventState, EventState>(
      builder: (context, eventState) => buildEventCard(context, eventState),
      converter: (eventStore) => eventStore.state,
    );
  }

  /// Separated build method because StoreBuilder is used
  Widget buildEventCard(BuildContext context, EventState eventState) {
    Map<String, Event> eventList = eventState.eventList;
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular((8.0)))),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: _buildImageBanner(eventList),
            onTap: () => _handleBannerOnTap(context, eventList),
          ),
          _buildTitleStrip(context, eventList),
          _buildTimeDateStrip(context, eventList),
        ],
      ),
    );
  }

  /// Builds CachedNetworkImage as Banner.
  /// This will also act as a Hero.
  Widget _buildImageBanner(Map<String, Event> eventList) {
    return DefParameterNetworkImage(
      imageUrl: eventList[this.eventID].headerImage,
      isCover: true,
    );
  }

  /// Build Time Date Data
  Widget _buildTimeDateStrip(
      BuildContext context, Map<String, Event> eventList) {
    return IconText(
      icon: Icons.timer,
      text: "${eventList[this.eventID].startTimeString}",
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  /// Build Title and flagging controller
  Widget _buildTitleStrip(BuildContext context, Map<String, Event> eventList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(eventList[this.eventID].eventName),
        subtitle: Text(eventList[this.eventID].organizer),
        trailing: FlaggingButton(this.eventID),
      ),
    );
  }

  /// Handles Tap on Banner.
  /// Will show EventImageView and animates Banner as a Hero.
  /// Use Fade animation as transition.
  void _handleBannerOnTap(BuildContext context, Map<String, Event> eventList) {
    TransitionMaker
        .slideTransition(
          destinationPageCall: () => EventDetails(eventList[this.eventID]),
        )
        .start(context);
  }

  EventCard(this.eventID);
  final String eventID;
}

/// Flagging button which dispatched flagging and unflagging events
class FlaggingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<EventState>(
      builder: (context, eventStore) {
        List<FlaggedEvent> flaggedList = eventStore.state.flaggedList;
        bool isFlagged = flaggedList.any((v) => v.eventID == this.eventID);
        return IconButton(
          icon: Icon(
            isFlagged
                ? FontAwesomeIcons.solidBookmark
                : FontAwesomeIcons.bookmark,
            color: isFlagged ? Theme.of(context).accentColor : null,
          ),
          onPressed: () => _handleFlagOnTap(context, isFlagged, eventStore),
        );
      },
    );
  }

  /// Handles tap on flag
  /// Toggled its flagged state
  void _handleFlagOnTap(
      BuildContext context, bool isFlagged, Store<EventState> eventStore) {
    if (isFlagged) {
      eventStore.dispatch(
          Actions.RemoveFromFlaggedList(this.eventID, DateTime.now()));
    } else {
      eventStore
          .dispatch(Actions.AddToFlaggedList(this.eventID, DateTime.now()));
    }
  }

  final String eventID;
  FlaggingButton(this.eventID);
}

/// Creates an Icon Text.
///
/// Main Color will be Primary Color.
/// Otherwise works as a normal text.
class IconText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: this.mainAxisAlignment,
        children: <Widget>[
          Icon(
            this.icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          Text(
            this.text,
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  IconText({this.icon, this.text, this.mainAxisAlignment});

  final IconData icon;
  final String text;
  final MainAxisAlignment mainAxisAlignment;
}
