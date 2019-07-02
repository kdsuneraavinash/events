import 'package:event_app/state/event.dart';
import 'package:event_app/state/query.dart';
import 'package:event_app/state/flagged.dart';
import 'package:event_app/state/notification.dart';

/// The main store object
/// Here this also is the VIew Model (No separate class for view modal)
class EventState {
  final Map<String, Event> eventList;
  final List<FlaggedEvent> flaggedList;
  final List<EventNotification> notifications;
  final QueryOptions searchOptions;
  // Will not be saved persistantly
  final String searchString;

  factory EventState.empty() {
    return EventState({}, [], [], QueryOptions.original(), "");
  }

  /// Contructor
  EventState(this.eventList, this.flaggedList, this.notifications,
      this.searchOptions, this.searchString);

  /// Copy state
  EventState copyWith(
      {Map<String, Event> eventList,
      List<FlaggedEvent> flaggedList,
      List<EventNotification> notifications,
      QueryOptions searchOptions,
      String searchString}) {
    eventList ??= this.eventList;
    flaggedList ??= this.flaggedList;
    notifications ??= this.notifications;
    searchOptions ??= this.searchOptions;
    searchString ??= this.searchString;
    return EventState(
        eventList, flaggedList, notifications, searchOptions, searchString);
  }

  ///
  /// json is a map like
  /// {
  /// 'eventList':[{'eventName':'Event 101', 'organizer': 'Nobody', ...}, {..}, ...]
  /// 'flaggedList': [{'eventID':'HHfd8sDDS', 'alarmStatus': true}, {..}, ...]
  /// 'notifications' : [{'message':'Event Added by Boo Boo', 'type': 'ADD'}, {..}, ...]
  /// 'queryOptions' : {'sortOption': 'start', 'orderOption': 'descending', ..}
  /// }
  ///
  static EventState fromJson(dynamic json) {
    // Parse Events
    Map<String, Event> eventList = {};
    for (Map<String, dynamic> parsedEvent in List.from(json["eventList"])) {
      Event newEvent = Event.fromJson(parsedEvent.values.elementAt(0));
      eventList[newEvent.id] = newEvent;
    }

    // Parse Flagged Events
    List<FlaggedEvent> flaggedList = [];
    for (Map<String, dynamic> parsedFlagged in List.from(json["flaggedList"])) {
      flaggedList.add(FlaggedEvent.fromJson(parsedFlagged));
    }

    // Parse Flagged Events
    List<EventNotification> notifications = [];
    for (Map<String, dynamic> parsedNotification
        in List.from(json["notifications"])) {
      notifications.add(EventNotification.fromJson(parsedNotification));
    }

    QueryOptions searchOptions = QueryOptions.fromMap(json['searchOptions']);

    String emptySearchString = "";

    return EventState(eventList, flaggedList, notifications, searchOptions,
        emptySearchString);
  }

  // Convert to Json
  dynamic toJson() {
    Map<String, dynamic> json = {};

    // Parse EventList to JSON
    List toParseEventList = [];
    for (String eventID in this.eventList.keys) {
      Event event = this.eventList[eventID];
      toParseEventList.add({eventID: event.toJson()});
    }
    json['eventList'] = toParseEventList;

    // Parse EventList to JSON
    List toParseFlaggedList = [];
    for (FlaggedEvent flagged in this.flaggedList) {
      toParseFlaggedList.add(flagged.toJson());
    }
    json['flaggedList'] = toParseFlaggedList;

    // Parse EventList to JSON
    List toParseNotificationsList = [];
    for (EventNotification notification in this.notifications) {
      toParseNotificationsList.add(notification.toJson());
    }
    json['notifications'] = toParseNotificationsList;

    json['searchOptions'] = this.searchOptions.toMap();

    return json;
  }
}
