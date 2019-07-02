import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Launch method for EventContact
enum LaunchMethod { CALL, MESSAGE, WEB, FACEBOOK }

/// Hold Event Organizer Contact Data
class EventContact {
  Map<LaunchMethod, List> _methodToPropertyMap = {
    LaunchMethod.CALL: [Icons.call, (v) => "tel:$v", "Call"],
    LaunchMethod.MESSAGE: [Icons.call, (v) => "sms:$v", "Message"],
    LaunchMethod.WEB: [Icons.web, (v) => "$v", "Website"],
    LaunchMethod.FACEBOOK: [Icons.web, (v) => "$v", "Facebook"],
  };

  Map<String, LaunchMethod> _stringToMethodMap = {
    "CALL": LaunchMethod.CALL,
    "MESSAGE": LaunchMethod.MESSAGE,
    "WEB": LaunchMethod.WEB,
    "FACEBOOK": LaunchMethod.FACEBOOK
  };

  String contactPerson;
  String contactLink;
  LaunchMethod method;

  /// Get Icon according to launch method
  IconData getIcon() => _methodToPropertyMap[this.method][0];

  /// Get Url to execute the method
  String getUrl() => _methodToPropertyMap[this.method][1];

  /// Get String according to contact method
  String getContactMethodString() => _methodToPropertyMap[this.method][2];

  EventContact(this.contactPerson, this.contactLink, this.method);

  EventContact.fromList(List<String> contact) {
    this.contactLink = contact[1];
    this.contactPerson = contact[0];
    this.method = _stringToMethodMap[contact[2]];
  }
}

/// Class to hold info on events
/// Will be used as main object to save, load, show info
class Event {
  final String eventName;
  final String organizer;
  final String startTimeString;
  final String endTimeString;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final List<String> images;
  final String headerImage; // Auto assigned
  final String description;
  final String location;
  final String id;
  //List<EventContact> contact = [];
  final List<String> tags = [];

  /// Main constructor
  Event(
      this.eventName,
      this.organizer,
      this.startTime,
      this.endTime,
      this.startTimeString,
      this.endTimeString,
      this.isAllDay,
      this.images,
      this.headerImage,
      this.description,
      this.location,
      this.id);

  /// Create from Firestore Doc
  factory Event.fromFirestoreDoc(DocumentSnapshot doc) {
    return new Event(
        doc.data['eventName'],
        doc.data['organizer'],
        doc.data['start'],
        doc.data['end'],
        getFormattedDate(doc.data['start'], doc.data['isAllDay']),
        getFormattedDate(doc.data['end'], doc.data['isAllDay']),
        doc.data['isAllDay'],
        List<String>.from(doc.data['images']),
        doc.data['images'][0],
        doc.data['description'],
        doc.data['location'],
        doc.documentID);
  }

  // Parse from JSON
  factory Event.fromJson(dynamic json) {
    return Event(
      json["eventName"], // String
      json["organizer"], // String
      // Connot convert staright to JSon
      // So will remember MillisecondsSinceEpoch and
      // Use that to convert back
      DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['startTime'])), // Date Time
      DateTime
          .fromMillisecondsSinceEpoch(int.parse(json['endTime'])), // Date Time
      json["startTimeString"], // String
      json["endTimeString"], // String
      json["isAllDay"], // bool
      List<String>.from(json["images"]), // List
      json["headerImage"], // String
      json["description"], // String
      json["location"], // String
      json["id"], // String
    );
  }

  /// Parse to JSON
  Map toJson() {
    return {
      "eventName": this.eventName,
      "organizer": this.organizer,
      "startTime": this.startTime.millisecondsSinceEpoch.toString(),
      "endTime": this.endTime.millisecondsSinceEpoch.toString(),
      "startTimeString": this.startTimeString,
      "endTimeString": this.endTimeString,
      "isAllDay": this.isAllDay,
      "images": this.images,
      "headerImage": this.headerImage,
      "description": this.description,
      "location": this.location,
      "id": this.id,
    };
  }

  // Format Date to string
  static String getFormattedDate(DateTime obj, bool isAllDay) {
    String str = "";
    List<String> months = [
      'Jan',
      'Feb',
      'March',
      'April',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    str += '${obj.year} ${months[obj.month - 1]} ${obj.day} ';
    if (!isAllDay)
      str +=
          'at ${(obj.hour % 12)}:${obj.minute.toString().padRight(2,'0')} ${obj.hour/12 == 0 ? "AM" : "PM"}';
    return str;
  }

  /// Create an event for test purposes
  /*
    for (List<String> _contact in eventData[7]) {
      this.contact.add(
            new EventContact.fromList(_contact),
          );
    }

    this.tags.add("Test");
    this.tags.add("Event");
    */
}
