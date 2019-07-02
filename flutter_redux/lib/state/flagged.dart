/// Class for flagged events
class FlaggedEvent {
  final String eventID;
  final bool alarmStatus;

  // Parse from JSON
  FlaggedEvent(this.eventID, this.alarmStatus);

  /// Parse from JSON
  factory FlaggedEvent.fromJson(Map<String, dynamic> json) {
    return FlaggedEvent(
      json["eventID"], // String
      json["alarmStatus"], // bool
    );
  }

  /// Parse to JSON
  Map toJson() {
    return {
      "eventID": this.eventID,
      "alarmStatus": this.alarmStatus,
    };
  }
}
