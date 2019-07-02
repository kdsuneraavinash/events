import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class EventView {
  final String name;
  final String organizer;
  final String venue;
  final String description;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final DateTime startMomentTime;
  final DateTime endMomentTime;
  final bool isAllDay;
  final int stars;
  final String coverImageUrl;
  final bool iLiked;

  String get startDate =>
      DateFormat("EEEE, MMMM d, yyyy").format(startDateTime);

  String get endDate => DateFormat("EEEE, MMMM d, yyyy").format(endDateTime);

  String get startTime => DateFormat("h:mm a").format(startMomentTime);

  String get endTime => DateFormat("h:mm a").format(endMomentTime);

  EventView(
      {this.name,
      this.organizer,
      this.venue,
      this.description,
      this.startDateTime,
      this.endDateTime,
      this.startMomentTime,
      this.endMomentTime,
      this.isAllDay,
      this.stars,
      this.coverImageUrl,
      this.iLiked});

  factory EventView.fromMap(Map<String, dynamic> map) {
    return EventView(
      name: map['name'],
      organizer: map['organizer'],
      venue: map['venue'],
      description: map['description'],
      startDateTime: DateTime.parse(map['startDateTime']),
      endDateTime: DateTime.parse(map['endDateTime']),
      startMomentTime: DateTime.parse(map['startMomentTime']),
      endMomentTime: DateTime.parse(map['endMomentTime']),
      isAllDay: map['isAllDay'],
      stars: map['stars'],
      coverImageUrl: map['coverImageUrl'],
      iLiked: map['iLiked'],
    );
  }

  factory EventView.fromIndex(int index) {
    return EventView(
      name: "Random Event ${index + 1}",
      organizer: "Fake Organizers Organization",
      venue: "Fake Town Hall",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
          "Praesent est arcu, placerat molestie sagittis non, vehicula "
          "non magna. Nunc vitae ornare ex. Duis quis tellus ultrices ante "
          "accumsan maximus eget sit amet nibh. Pellentesque sit amet varius "
          "dui, id mattis elit. Suspendisse luctus eleifend purus, tristique "
          "convallis ex malesuada id. Quisque et libero a quam facilisis tempor. "
          "Fusce eleifend ipsum nec aliquam fermentum. Vivamus egestas imperdiet "
          "felis eget pharetra. Nam non tincidunt arcu, quis rutrum risus. "
          "Pellentesque ultricies enim sit amet accumsan feugiat. Curabitur "
          "ut eros in elit ultricies pulvinar. Nuldlam molestie felis vitae dolor "
          "congue, sed auctor urna scelerisque.\n\nAenean aliquet, massa ac accumsan "
          "fringilla, sem arcu sagittis augue, eu aliquam purus dui sit amet felis. "
          "Proin sed quam nec orci elementum egestas nec at dui. Ut sit amet urna "
          "fringilla, posuere eros sit amet, consequat magna. Morbi elementum, nunc "
          "congue tincidunt scelerisque, magna quam cursus erat, dignissim iaculis "
          "ex justo eu justo. Nudllam lobortis lacus at velit aliquam, quis tempor "
          "mauris pulvinar. Interdum et malesuada fames ac ante ipsum primis in faucibus. "
          "Aliquam condimentum risus at libero placerat ultricies. Nam dictum efficitur "
          "neque, vel tempus orci pulvinar vitae. Cras eu nibh tortor. Morbi elit quam, "
          "blandit varius varius tempus, viverra non neque. Vestibulum ut turpis in enim "
          "fringilla pellentesque porta in leo.\n\nVisit: https://www.google.com",
      startDateTime: DateTime.now(),
      endDateTime: DateTime.now().add(Duration(days: (index * 601) % 100)),
      startMomentTime: DateTime(0, 0, 0, 8, 30),
      endMomentTime: DateTime(0, 0, 0, 18, 30),
      isAllDay: (index * 5.1346) % 2 > 1,
      coverImageUrl: "https://picsum.photos/400/300?image=$index",
      stars: ((index + 6) * (index * index - index + 4)) % 100,
      iLiked: (index * 1.3432134) % 2 > 1,
    );
  }
}
