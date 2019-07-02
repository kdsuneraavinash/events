import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:event_app/state/query.dart';
import 'package:event_app/state/notification.dart';

// Actions:
//  Will only contain classes to distinguish each command for reducer and
// contain actions

/// Add an event to flagged event list
class AddToFlaggedList {
  final String eventToAddID;
  final DateTime time;

  AddToFlaggedList(this.eventToAddID, this.time);
}

/// Remove an event from flagged event list
class RemoveFromFlaggedList {
  final String eventToRemoveID;
  final DateTime time;

  RemoveFromFlaggedList(this.eventToRemoveID, this.time);
}

/// Change alarm state
class ChangeAlarmState {
  final String alarmEventID;
  final bool state;
  final DateTime time;

  ChangeAlarmState(this.alarmEventID, this.state, this.time);
}

/// Add a notification
class AddNotification {
  final String text;
  final NotificationType type;
  final DateTime time;

  AddNotification(this.text, this.type, this.time);
}

/// Marks all notifications as read.
class MarkNotificationsAsRead {}

/// Clear all notifications
class ClearNotifications {}

/// Start listening to firestore updates
class FirestoreListenToUpdates {
  final String type;

  FirestoreListenToUpdates({this.type});
}

//// Refresh all events once
class FirestoreRefreshAll {
  final String type;

  FirestoreRefreshAll({this.type});
}

/// Stop listening to firestore updates
class FirestoreEndConnection {}

class FirestoreDocumentsChanged {
  final QuerySnapshot querySnapshot;
  final DateTime time;

  FirestoreDocumentsChanged(this.querySnapshot, this.time);
}

/// User set some search options from search options dialog
class SearchOptionsSet {
  final QueryOptions newSearchOptions;

  SearchOptionsSet(this.newSearchOptions);
}

/// User is searching something by typing into search field
class SearchStringSet {
  final String searchString;

  SearchStringSet(this.searchString);
}
