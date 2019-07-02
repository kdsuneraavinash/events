import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_persist/redux_persist.dart';

import 'package:event_app/state/event.dart';
import 'package:event_app/state/flagged.dart';
import 'package:event_app/state/notification.dart';
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/redux_store/actions.dart';

/// Connect to all reducers
EventState reducers(EventState eventState, dynamic action) {
  if (action is AddToFlaggedList) {
    return addToFlaggedListReducer(eventState, action);
  } else if (action is RemoveFromFlaggedList) {
    return removeFromFlaggedListReducer(eventState, action);
  } else if (action is ChangeAlarmState) {
    return changeAlarmState(eventState, action);
  } else if (action is MarkNotificationsAsRead) {
    return markNotificationsAsReadReducer(eventState, action);
  } else if (action is ClearNotifications) {
    return clearNotificationsReducer(eventState, action);
  } else if (action is FirestoreDocumentsChanged) {
    return firestoreEventsAddedReducer(eventState, action);
  } else if (action is SearchOptionsSet) {
    return searchOptionsSetReducer(eventState, action);
  } else if (action is SearchStringSet) {
    return searchStringSetReducer(eventState, action);
  } else if (action is AddNotification) {
    return addNotificationReducer(eventState, action);
  } else if (action is PersistLoadedAction<EventState>) {
    return persistLoadedActionReducer(eventState, action);
  } else {
    return eventState.copyWith();
  }
}

/// Event Store Loaded
/// flutter_redux_persist action
EventState persistLoadedActionReducer(
    EventState eventState, PersistLoadedAction action) {
  if (action.state == null) return eventState;
  return action.state;
}

/// Add event to flagged events list
/// returns a copy of original list
EventState addToFlaggedListReducer(
    EventState eventState, AddToFlaggedList action) {
  return eventState.copyWith(
    flaggedList: List.from(eventState.flaggedList)
      ..add(
        // Adds to flagged list: default alarm state is True
        FlaggedEvent(action.eventToAddID, true),
      ),
  );
}

/// Remove event from flagged events list
/// returns a copy of original list
EventState removeFromFlaggedListReducer(
    EventState eventState, RemoveFromFlaggedList action) {
  return eventState.copyWith(
    flaggedList: List.from(eventState.flaggedList)
      ..removeWhere((v) => v.eventID == action.eventToRemoveID),
  );
}

EventState addNotificationReducer(
    EventState eventState, AddNotification action) {
  return eventState.copyWith(
    notifications: List.from(eventState.notifications)
      ..add(
        // Add a notification
        EventNotification(
          action.text,
          action.type,
          action.time,
        ),
      ),
  );
}

/// Alarm turned ON or turned OFF
EventState changeAlarmState(EventState eventState, ChangeAlarmState action) {
  List<FlaggedEvent> flaggedList = List.from(eventState.flaggedList);

  // Create new flagged item with alarm state off/on depending on state
  for (int index = 0; index < eventState.flaggedList.length; index++) {
    if (flaggedList[index].eventID == action.alarmEventID) {
      flaggedList[index] = FlaggedEvent(action.alarmEventID, action.state);
    }
  }

  return eventState.copyWith(flaggedList: flaggedList);
}

///Marks all notifications as read
EventState markNotificationsAsReadReducer(
    EventState eventState, MarkNotificationsAsRead action) {
  return eventState.copyWith(
    notifications: eventState.notifications
        .map((v) =>
            // New notification mapping with marked as read
            EventNotification(v.message, v.type, v.timestamp)..markAsRead())
        .toList(),
  );
}

/// Empty all notifications
EventState clearNotificationsReducer(
    EventState eventState, ClearNotifications action) {
  return eventState.copyWith(notifications: List());
}

/// Loaded all events from Firebase
/// Have to do few tasks
/// * load all events to allEvents
/// * Filter flagged items which are only present in both
/// (Remove flagged items which are not in new list)
/// TODO: Optimize this to retrieve and change only document changes
EventState firestoreEventsAddedReducer(
    EventState eventState, FirestoreDocumentsChanged action) {
  // Get all events
  Map<String, Event> allEvents = {};
  List<DocumentSnapshot> documents = action.querySnapshot.documents;

  for (DocumentSnapshot doc in documents) {
    allEvents[doc.documentID] = Event.fromFirestoreDoc(doc);
  }

  /// Get all flagged events that are in current events and update their event property
  List<FlaggedEvent> allFlagged = [];
  // For each old event
  for (String newEventID in allEvents.keys) {
    // check new events
    for (FlaggedEvent flagged in eventState.flaggedList) {
      // whether there is a item with same id
      if (flagged.eventID == newEventID) {
        // if there is; add that event to flagged events because it is present in both lists
        allFlagged.add(FlaggedEvent(newEventID, flagged.alarmStatus));
        break;
      }
    }
  }
  return eventState.copyWith(eventList: allEvents, flaggedList: allFlagged);
}

/// User set search options (Filter dialog)
EventState searchOptionsSetReducer(
    EventState eventState, SearchOptionsSet action) {
  return eventState.copyWith(searchOptions: action.newSearchOptions);
}

/// User set search strings (Search box)
EventState searchStringSetReducer(
    EventState eventState, SearchStringSet action) {
  return eventState.copyWith(searchString: action.searchString);
}
