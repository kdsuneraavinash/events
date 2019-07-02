import 'package:flutter/material.dart';

/// Type of notification. Will change icon.
enum NotificationType { ADD, MESSAGE }

/// Class to hold notification data
class EventNotification {
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool read = false;

  EventNotification(this.message, this.type, this.timestamp, [this.read = false]);

  /// Marks as read
  void markAsRead() {
    read = true;
  }

  /// Choose Icon by notification type
  IconData getIcon() {
    switch (this.type) {
      case NotificationType.ADD:
        return Icons.event;
      case NotificationType.MESSAGE:
        return Icons.message;
      default:
        return Icons.info;
    }
  }

  /// Parse type from String
  static NotificationType getTypeFromString(String type) {
    switch (type) {
      case 'ADD':
        return NotificationType.ADD;
      case 'MESSAGE':
      default:
        return NotificationType.MESSAGE;
    }
  }

  /// Parse string from type
  static String getStringFromType(NotificationType type) {
    switch (type) {
      case NotificationType.ADD:
        return 'ADD';
      case NotificationType.MESSAGE:
      default:
        return 'MESSAGE';
    }
  }

  // Parse from JSON
  factory EventNotification.fromJson(Map<String, dynamic> json) {
    // Notification type convert from String
    return EventNotification(
      json["message"], // String
      EventNotification.getTypeFromString(json["type"]), // NotificationType
      DateTime.fromMillisecondsSinceEpoch(json["timestamp"]), // Date Time
      json["read"] ?? false // Boolean [Patch for old version]
    );
  }

  /// Parse to JSON
  Map toJson() {
    return {
      "message": this.message,
      "type": getStringFromType(this.type),
      "timestamp": this.timestamp.millisecondsSinceEpoch,
      "read": this.read
    };
  }
}
