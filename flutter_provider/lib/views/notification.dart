import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

enum Action { ADD, START, END }

@immutable
abstract class NotificationView {
  final DateTime notificationTime;
  final bool isRead;

  NotificationView({this.notificationTime, this.isRead});

  String get messageStart;
  String get messageMiddle;
  String get messageEnd;
  String get dateString => timeago.format(notificationTime);
  IconData get icon;

  factory NotificationView.fromIndex(int index) {
    double randomized = (index * index * 5.1346) % 3;
    bool isRead = index  > 5;
    DateTime notifTime = DateTime.now();

    if (randomized > 2) {
      return AddEventNotificationView(
        isRead: isRead,
        organizer: "Random Organizers",
        notificationTime: notifTime,
      );
    } else if (randomized > 1) {
      return EventStartNotificationView(
        isRead: isRead,
        eventName: "Random Event",
        notificationTime: notifTime,
      );
    } else {
      return EventEndNotificationView(
        isRead: isRead,
        eventName: "Random Event",
        notificationTime: notifTime,
      );
    }
  }
}

@immutable
class AddEventNotificationView extends NotificationView {
  final String organizer;

  AddEventNotificationView({
    this.organizer,
    notificationTime,
    isRead,
  }) : super(notificationTime: notificationTime, isRead: isRead);

  @override
  IconData get icon => FontAwesomeIcons.plus;

  @override
  String get messageEnd => "new Event.";

  @override
  String get messageMiddle => " added a ";

  @override
  String get messageStart => organizer;
}

@immutable
abstract class EventTimeNotificationView extends NotificationView {
  final String eventName;

  EventTimeNotificationView({
    this.eventName,
    notificationTime,
    isRead,
  }) : super(notificationTime: notificationTime, isRead: isRead);

  @override
  IconData get icon => FontAwesomeIcons.hourglassStart;

  @override
  String get messageEnd => "";

  @override
  String get messageStart => eventName;
}

@immutable
class EventStartNotificationView extends EventTimeNotificationView {
  EventStartNotificationView({
    eventName,
    notificationTime,
    isRead,
  }) : super(
            eventName: eventName,
            notificationTime: notificationTime,
            isRead: isRead);

  @override
  String get messageMiddle => " started.";
}

class EventEndNotificationView extends EventTimeNotificationView {
  EventEndNotificationView({
    eventName,
    notificationTime,
    isRead,
  }) : super(
            eventName: eventName,
            notificationTime: notificationTime,
            isRead: isRead);

  @override
  String get messageMiddle => " ended.";
}
