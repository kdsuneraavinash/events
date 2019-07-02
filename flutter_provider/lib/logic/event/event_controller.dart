import 'package:events/json/events.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';

class EventViewController extends ChangeNotifier {
  List<EventView> _events;

  EventViewController() {
    _events = [];
  }

  EventView ofIndex(int index) {
    if (index >= _events.length) {
      return null;
    }
    return _events[index];
  }

  factory EventViewController.fromLocalFile() {
    List<Map<String, dynamic>> data = EventsJson.data;
    EventViewController controller = EventViewController();
    controller._events =
        data.map<EventView>((v) => EventView.fromMap(v)).toList();
    return controller;
  }
}
